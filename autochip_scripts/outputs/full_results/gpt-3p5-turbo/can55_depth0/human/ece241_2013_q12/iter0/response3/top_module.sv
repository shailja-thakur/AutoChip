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
wire [2:0] ABC;
assign ABC = {A, B, C};

// 8-bit shift register
always @(posedge clk) begin
	if (enable) begin
		Q[7] <= S;
		Q[6] <= Q[7];
		Q[5] <= Q[6];
		Q[4] <= Q[5];
		Q[3] <= Q[4];
		Q[2] <= Q[3];
		Q[1] <= Q[2];
		Q[0] <= Q[1];
	end
end

// Multiplexer to select output based on ABC
always @(*) begin
	case (ABC)
		3'b000: Z = Q[0];
		3'b001: Z = Q[1];
		3'b010: Z = Q[2];
		3'b011: Z = Q[3];
		3'b100: Z = Q[4];
		3'b101: Z = Q[5];
		3'b110: Z = Q[6];
		3'b111: Z = Q[7];
	endcase
end

endmodule
