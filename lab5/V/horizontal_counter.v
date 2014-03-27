module horizontal_counter (
           input VSYNC,
           input HSYNC,
           input clock,
           input [ 2: 0 ] count,
           output reg [ 5: 0 ] Hcount );



initial begin
    Hcount <= 0;
end


always @ ( posedge clock ) begin

    if ( count == 7 ) begin
        Hcount <= Hcount + 1;
    end
    if ( VSYNC == 0 || HSYNC == 0 ) begin
        Hcount <= 0;
    end


end

endmodule
