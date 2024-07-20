module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] Q; // register outputs

always @(posedge clk)
begin
	if (enable)
	begin
		Q[0] <= S; // shift input into Q[0]
		Q[1] <= Q[0]; // shift Q[0] into Q[1]
		Q[2] <= Q[1]; // shift Q[1] into Q[2]
		Q[3] <= Q[2]; // shift Q[2] into Q[3]
		Q[4] <= Q[3]; // shift Q[3] into Q[4]
		Q[5] <= Q[4]; // shift Q[4] into Q[5]
		Q[6] <= Q[5]; // shift Q[5] into Q[6]
		Q[7] <= Q[6]; // shift Q[6] into Q[7]
	end
end

always @*
begin
	case ({A, B, C})
		3'b000: Z = Q[0];
		3'b001: Z = Q[1];
		3'b010: Z = Q[2];
		3'b011: Z = Q[3];
		3'b100: Z = Q[4];
		3'b101: Z = Q[5];
		3'b110: Z = Q[6];
		3'b111: Z = Q[7];
		default: Z = 0;
	endcase
end

endmodule
