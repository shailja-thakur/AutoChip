module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg [7:0] q,  // 8-bit register
	output reg [2:0] Z   // 3-bit multiplexer
);

	always @(posedge clk) begin
		if (enable)
			q <= {q[6:0], S};  // shift in S input when enable is high
	end

	always @(*) begin
		case ({A, B, C})
			3'b000: Z <= q[0];
			3'b001: Z <= q[1];
			3'b010: Z <= q[2];
			3'b011: Z <= q[3];
			3'b100: Z <= q[4];
			3'b101: Z <= q[5];
			3'b110: Z <= q[6];
			3'b111: Z <= q[7];
			default: Z <= 0;  // default case for invalid input combinations
		endcase
	end

endmodule
