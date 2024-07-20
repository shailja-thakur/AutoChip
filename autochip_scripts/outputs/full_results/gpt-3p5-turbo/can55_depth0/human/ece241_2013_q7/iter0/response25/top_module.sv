module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

	always @(posedge clk) begin
		case ({j, k})
			2'b00: Q <= Q; // Q remains unchanged
			2'b01: Q <= 1'b0; // Q is set to 0
			2'b10: Q <= 1'b1; // Q is set to 1
			2'b11: Q <= ~Q; // Q is complemented
		endcase
	end

endmodule
