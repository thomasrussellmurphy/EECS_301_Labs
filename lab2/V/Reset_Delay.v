module	Reset_Delay( iCLK, oRESET );
input	iCLK;
output reg	oRESET;
reg	[ 19: 0 ] Cont;

always@( posedge iCLK ) begin
    if ( Cont != 20'hFFFFF ) begin
        Cont	<= Cont + 1;
        oRESET	<= 1'b0;
    end
    else begin
        oRESET	<= 1'b1;
    end
end

endmodule
