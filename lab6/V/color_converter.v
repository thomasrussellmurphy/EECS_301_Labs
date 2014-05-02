module color_converter( clk_9, in_source_data, en, red_pix, blue_pix, green_pix );

input clk_9;
input en;
input [ 15: 0 ] in_source_data;

output reg [ 7: 0 ] red_pix;
output reg [ 7: 0 ] blue_pix;
output reg [ 7: 0 ] green_pix;

always @( posedge clk_9 ) begin

    if ( en ) begin

        red_pix <= { in_source_data[ 7: 0 ] };
        blue_pix <= { in_source_data[ 15: 8 ] };
        green_pix <= 8'b00000000;

    end

end
endmodule
