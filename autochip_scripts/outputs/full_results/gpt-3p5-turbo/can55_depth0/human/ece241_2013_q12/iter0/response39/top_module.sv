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
reg [2:0] index;

always @(posedge clk) begin
	if (enable) begin
		Q <= {S, Q[7:1]};
	end
end

always @* begin
	case ({A, B, C})
		3'b000: index = 3'b000;
		3'b001: index = 3'b001;
		3'b010: index = 3'b010;
		3'b011: index = 3'b011;
		3'b100: index = 3'b100;
		3'b101: index = 3'b101;
		3'b110: index = 3'b110;
		3'b111: index = 3'b111;
	endcase
	
	Z = Q[index];
end

endmodule
