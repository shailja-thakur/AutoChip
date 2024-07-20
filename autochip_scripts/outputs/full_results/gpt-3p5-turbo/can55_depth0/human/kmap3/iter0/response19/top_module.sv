module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(a, b, c, d) begin
		case ({a, b, c})
			3'b000, 3'b001: out = 1;
			3'b100, 3'b101, 3'b110, 3'b111: out = 1;
			default: out = 0;
		endcase
	end

endmodule
