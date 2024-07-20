module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({a,b,c})
		3'b000, 3'b001, 3'b010: out = d;
		3'b100, 3'b101: out = 0;
		3'b011, 3'b110, 3'b111: out = 1;
	endcase
end

endmodule
