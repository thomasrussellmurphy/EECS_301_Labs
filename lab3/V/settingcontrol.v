module settingcontrol( clk, reset, en, encA, encB, mode, phaseinc, gain );
parameter MIDFREQ = 14'd1048;
parameter DEFAULTGAIN = 9'b00100000; // set gain to ~0.5
parameter MININCREMENT = 15'd21;
parameter MAXINCREMENT = 15'd20971;

input wire clk;
input wire reset;
input wire en;
input wire encA, encB, mode; // mode 1:volume, 0:frequency
output reg [ 14: 0 ] phaseinc;
output reg [ 8: 0 ] gain; // 8-bit 2's complement

reg lasta;
reg inc, dec; // using these is pretty janky

always@( posedge clk ) begin
    lasta <= encA; // record A for edge detection
    if ( reset ) begin // reset and be done
        phaseinc <= MIDFREQ;
        gain <= DEFAULTGAIN;
    end
    else begin
        if ( encA & ~lasta ) begin // detect edge, count up or down
            if ( encB ) begin
                inc <= 1'b1;
            end
            else begin
                dec <= 1'b1;
            end
        end
    end

    // Act on mode, inc/dec flags
    if ( mode & ( inc | dec ) ) begin
        // Limit gain to 8-bit range of positive 2's complement
        if ( inc && gain != 9'b011111111 ) begin
            gain <= gain + 1'b1;
        end
        if ( dec && gain != 9'b000000000 ) begin
            gain <= gain - 1'b1;
        end
        inc <= 1'b0;
        dec <= 1'b0;
    end
    if ( ~mode & ( inc | dec ) ) begin
        // TODO: Limit phase to create 20-20k Hz range correctly
        if ( inc && phaseinc != MAXINCREMENT ) begin
            phaseinc <= phaseinc + 1'b1;
        end
        if ( dec && phaseinc != MININCREMENT ) begin
            phaseinc <= phaseinc - 1'b1;
        end
        inc <= 1'b0;
        dec <= 1'b0;
    end
end

endmodule
