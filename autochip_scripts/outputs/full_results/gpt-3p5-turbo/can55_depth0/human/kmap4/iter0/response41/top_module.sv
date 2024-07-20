module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*)
begin
	case({a,b})
		2'b00: if({c,d}==2'b01 || {c,d}==2'b10) out=0;
                     else out=1;
		2'b01: if({c,d}==2'b00 || {c,d}==2'b11) out=1;
                     else out=0;
		2'b11: if({c,d}==2'b00 || {c,d}==2'b11) out=0;
                     else out=1;
		2'b10: if({c,d}==2'b01 || {c,d}==2'b10) out=1;
                     else out=0;
	endcase
end

endmodule
