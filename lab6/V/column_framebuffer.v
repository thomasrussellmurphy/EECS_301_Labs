module column_framebuffer ( clk_data, clk_disp,
                            sink_valid, sink_data,
                            v_pos, source_enable,
                            source_data
                          );

input wire clk_data, clk_disp; // write and read clocks, respectively

input wire sink_valid; // RAM's write-enable
input wire [ 15: 0 ] sink_data; // RAM's write-data
input wire [ 9: 0 ] v_pos; // RAM's desired read point

input wire source_enable; // Read data from source rather than getting zeros
output reg [ 15: 0 ] source_data; // RAM's read-data

reg [ 9: 0 ] top_pixel; // virtual zero-index for
reg [ 15: 0 ] ram [ 1023: 0 ]; // 16-bit data, 10-bit address RAM

// Write-side behavior
always @( posedge clk_data ) begin
    if ( sink_valid ) begin
        ram[ top_pixel - 1'b1 ] <= sink_data;
        top_pixel <= top_pixel - 1'b1;
    end
    else begin
        top_pixel <= top_pixel;
    end
end

// Read-side behavior
always @( posedge clk_disp ) begin
    if ( source_enable ) begin
        source_data <= ram[ top_pixel + v_pos ];
    end
    else begin
        source_data <= 16'b0;
    end
end

endmodule
