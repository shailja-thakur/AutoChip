module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

	reg [7:0] Q;
	always @(posedge clk) begin
		if (enable) begin
			Q[0] <= S;
			Q[1] <= Q[0];
			Q[2] <= Q[1];
			Q[3] <= Q[2];
			Q[4] <= Q[3];
			Q[5] <= Q[4];
			Q[6] <= Q[5];
			Q[7] <= Q[6];
		end
	end

	always @(A or B or C or Q) begin
		case ({A, B, C})
			3'b000: Z <= Q[0];
			3'b001: Z <= Q[1];
			3'b010: Z <= Q[2];
			3'b011: Z <= Q[3];
			3'b100: Z <= Q[4];
			3'b101: Z <= Q[5];
			3'b110: Z <= Q[6];
			3'b111: Z <= Q[7];
		endcase
	end

endmodule
