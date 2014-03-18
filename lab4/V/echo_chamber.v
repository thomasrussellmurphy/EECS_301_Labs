module echo_chamber( clk, sample_w, in_sample, sample_r, out_sample );
input wire clk;
input wire sample_w, sample_r;
input wire [ 11: 0 ] in_sample;

output wire [ 11: 0 ] out_sample;

parameter fill = 12'd4000;

wire [ 11: 0 ] delayed_sample;
wire [ 16: 0 ] used;
reg read, write;
wire edge_w, edge_r;

always @( posedge clk ) begin
    if ( used < fill ) begin
        write <= edge_w;
        read <= 1'b0;
    end
    else begin
        write <= edge_w;
        read <= edge_r;
    end
end

fifo_4096x12 buffer ( .clock( clk ), .data( in_sample ), .rdreq( read ), .wrreq( write ), .empty(), .full(), .q( delayed_sample ), .usedw( used ) );
edge_to_pulse sample_w_edger ( .clk( clk ), .in( sample_w ), .out( edge_w ) );
edge_to_pulse sample_r_edger ( .clk( clk ), .in( sample_r ), .out( edge_r ) );
clipping_adder12 clipping_adder ( .clk( clk ), .dataa( { 1'b0, in_sample[ 11: 1 ] } ), .datab( { 4'b000, delayed_sample[ 11: 3 ] } ), .result( out_sample ) );
//assign out_sample = in_sample | delayed_sample;

endmodule
