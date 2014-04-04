module font_test_gen
       (
           input wire clk,
           input wire video_on,
           input wire [ 9: 0 ] pixel_x , pixel_y ,
           output reg [ 7: 0 ] red_out, green_out, blue_out
       );

// signal declaration
wire [ 10: 0 ] rom_addr;
wire [ 6: 0 ] char_addr;
wire [ 3: 0 ] row_addr;
wire [ 2: 0 ] bit_addr;
wire [ 7: 0 ] font_word;
wire font_bit , text_bit_on;


// body
// instantiate font ROM
fontrom font_unit ( .clk( clk ), .addr( rom_addr ), .data( font_word ) );


// font ROM interface
assign char_addr = { pixel_y [ 5: 4 ] , pixel_x [ 7: 3 ] };
assign row_addr = pixel_y [ 3: 0 ] ;
assign rom_addr = { char_addr , row_addr };
assign bit_addr = pixel_x [ 2: 0 ];
assign font_bit = font_word[ ~bit_addr ] ;

// "on" region limited to top-left corner
assign text_bit_on = ( pixel_x [ 9: 8 ] == 0 && pixel_y [ 9: 6 ] == 0 ) ? font_bit : 1'b0;

// rgb multiplexing circuit
always @( * ) begin
    if ( ~video_on ) begin
        red_out <= 8'h00; // Blank
        green_out <= 8'h00; // Blank
        blue_out <= 8'h00; // Blank
    end
    else begin
        if ( text_bit_on ) begin // Make the text output red-ish
            red_out <= 8'hff;
            green_out <= 8'h10;
            blue_out <= 8'h20;
        end

        else begin // Text background
            red_out <= 8'h11;
            green_out <= 8'h11;
            blue_out <= 8'h11; 
        end
    end
end
endmodule
