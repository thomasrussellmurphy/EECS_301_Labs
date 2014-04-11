module button_conditioner( clk, btn, btn_conditioned );
input wire clk;
input wire [ 2: 0 ] btn;
output wire [ 2: 0 ] btn_conditioned;

wire [ 2: 0 ] btn_debounce;

button_debouncer debounce0 ( .clk( clk ), .rst_n( 1'b1 ), .data_in( btn[ 0 ] ), .data_out( btn_debounce[ 0 ] ) );
button_debouncer debounce1 ( .clk( clk ), .rst_n( 1'b1 ), .data_in( btn[ 1 ] ), .data_out( btn_debounce[ 1 ] ) );
button_debouncer debounce2 ( .clk( clk ), .rst_n( 1'b1 ), .data_in( btn[ 2 ] ), .data_out( btn_debounce[ 2 ] ) );

edge_to_pulse pulse0( .clk( clk ), .in( btn_debounce[ 0 ] ), .out( btn_conditioned[ 0 ] ) );
edge_to_pulse pulse1( .clk( clk ), .in( btn_debounce[ 1 ] ), .out( btn_conditioned[ 1 ] ) );
edge_to_pulse pulse2( .clk( clk ), .in( btn_debounce[ 2 ] ), .out( btn_conditioned[ 2 ] ) );

endmodule
