module character_storage
       (
			  input wire reset,
			  input wire [2:0] btn,
			  input wire [6:0] sw,
           input wire clk,
           input wire video_on,
           input wire [ 9: 0 ] pixel_x , pixel_y ,
           output reg [ 7: 0 ] red_out, green_out, blue_out
			 

       );


   // signal declaration
   // font ROM
   wire [10:0] rom_addr;
   wire [6:0] char_addr;
   wire [3:0] row_addr;
   wire [2:0] bit_addr;
   wire [7:0] font_word;
   wire font_bit;
   

   // tile RAM
   wire we;
   wire [11:0] addr_r, addr_w;
   wire [6:0] din, dout;
   // 80-by-30 tile map
   localparam MAX_X = 80;
   localparam MAX_Y = 30;
   // cursor
   reg [6:0] cur_x_reg;
   wire [6:0] cur_x_next;
   reg [4:0] cur_y_reg;
   wire [4:0]cur_y_next;
   wire move_x_tick, move_y_tick, cursor_on;
   // delayed pixel count
   reg [9:0] pix_x1_reg, pix_y1_reg;
   reg [9:0] pix_x2_reg, pix_y2_reg;
   // object output signals
   wire [7:0] font_red_out, font_green_out, font_blue_out;
   wire [7:0] font_rev_red_out, font_rev_green_out, font_rev_blue_out;

   // instantiate font ROM
   fontrom font_unit ( .clk( clk ), .addr( rom_addr ), .data( font_word ) );
   // instantiate dual-port video RAM (2^12-by-7)
  xilinx_dual_port_ram_sync
     #(.ADDR_WIDTH(12), .DATA_WIDTH(7)) video_ram
      (.clk(clk), .we(we), .addr_a(addr_w), .addr_b(addr_r),
      .din_a(din), .dout_a(), .dout_b(dout));

   // registers
   always @(posedge clk)
      begin
         cur_x_reg <= cur_x_next;
         cur_y_reg <= cur_y_next;
         pix_x1_reg <= pixel_x;
         pix_x2_reg <= pix_x1_reg;
         pix_y1_reg <= pixel_y;
         pix_y2_reg <= pix_y1_reg;
      end
   // tile RAM write
   assign addr_w = {cur_y_reg, cur_x_reg};
   assign we = btn[2];
   assign din = sw;
  
 // tile RAM read
   // use nondelayed coordinates to form tile RAM address
   assign addr_r = {pixel_y[8:4], pixel_x[9:3]};
   assign char_addr = dout;
   // font ROM
   assign row_addr = pixel_y[3:0];
   assign rom_addr = {char_addr, row_addr};
   // use delayed coordinate to select a bit
   assign bit_addr = pix_x2_reg[2:0];
   assign font_bit = font_word[~bit_addr];
   // new cursor position
   assign cur_x_next =
      (move_x_tick && (cur_x_reg==MAX_X-1)) ? 0 : // wrap
      (move_x_tick) ? cur_x_reg + 1 :
                      cur_x_reg;
   assign cur_y_next =
      (move_y_tick && (cur_x_reg==MAX_Y-1)) ? 0 : // wrap
      (move_y_tick) ? cur_y_reg + 1 :
                      cur_y_reg;
   // object signals
   // green over black and reversed video for cursor
   assign font_red_out = (font_bit) ? 8'hff : 8'h00;
   assign font_green_out = (font_bit) ? 8'h10 : 8'h00;
   assign font_blue_out = (font_bit) ? 8'h20 : 8'h00;


   assign font_rev_red_out = (font_bit) ? 8'h00 : 8'hff;
   assign font_rev_green_out = (font_bit) ? 8'h00 : 8'h10;
   assign font_rev_blue_out = (font_bit) ? 8'h00 : 8'h20;

   // use delayed coordinates for comparison
   assign cursor_on = (pix_y2_reg[8:4]==cur_y_reg) &&
                      (pix_x2_reg[9:3]==cur_x_reg);
   // rgb multiplexing circuit
   always @*
      if (~video_on)
	begin
         red_out <= 8'h00; // Blank
         green_out <= 8'h00; // Blank
         blue_out <= 8'h00; // Blank
	end

      else
         if (cursor_on)
			begin
            red_out = font_rev_red_out;
				green_out = font_rev_green_out;
				blue_out = font_rev_blue_out;
				end
          else
			 begin
            red_out = font_red_out;
				green_out = font_green_out;
				blue_out = font_blue_out;
				end
endmodule




