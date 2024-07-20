module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	
	always @(a, b, c, d) begin
		case({c, d})
			2'b00: out = d;
			2'b01: out = 0;
			2'b10: out = 1;
			2'b11: out = 1;
			default: out = 0; // Added default case to handle any input combination not covered above
		endcase
	end

endmodule
