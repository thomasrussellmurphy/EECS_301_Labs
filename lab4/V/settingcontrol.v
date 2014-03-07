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

initial begin
    phaseinc <= MIDFREQ;
    gain <= DEFAULTGAIN;
end

always@( posedge clk ) begin
    lasta <= encA; // record A for edge detection

    if ( reset ) begin // reset and be done
        phaseinc <= MIDFREQ;
        gain <= DEFAULTGAIN;
    end
    else begin
        // Change volume
        if ( mode ) begin
            if ( encA & ~lasta ) begin // Edge detect
                // Limit gain to 8-bit range of positive 2's complement
                if ( encB && gain != 9'b011111111 ) begin
                    gain <= gain + 1'b1;
                end
                else if ( gain != 9'b000000000 ) begin
                    gain <= gain - 1'b1;
                end
            end
        end
        // Change frequency
        else begin
            if ( encA & ~lasta ) begin // Edge detect
                // TODO: Limit phase to create 20-20k Hz range correctly
                if ( encB && phaseinc != MAXINCREMENT ) begin
                    phaseinc <= phaseinc + 1'b1;
                end
                else if ( phaseinc != MININCREMENT ) begin
                    phaseinc <= phaseinc - 1'b1;
                end
            end
        end
    end

end
endmodule
