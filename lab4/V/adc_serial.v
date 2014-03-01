module adc_serial(sclk, parallelDataOut, sdo, sdi, sync);
input wire sclk;
input wire sync;

output wire [11:0] parallelDataOut;
output wire sdo, sdi;

parameter COMMAND = 16'b0; // TODO: get command for desired functionality

endmodule
