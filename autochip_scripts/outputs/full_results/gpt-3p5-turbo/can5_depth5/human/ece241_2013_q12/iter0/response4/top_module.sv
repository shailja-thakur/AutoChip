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
reg [2:0] address;

// 8-bit shift register
always @(posedge clk) begin
	if (enable) begin
		Q <= {S, Q[7:1]};
	end
end

// 3-input mux for address selection
always @(A or B or C) begin
	case ({A, B, C})
		3'b000: address <= 3'b000;
		3'b001: address <= 3'b001;
		3'b010: address <= 3'b010;
		3'b011: address <= 3'b011;
		3'b100: address <= 3'b100;
		3'b101: address <= 3'b101;
		3'b110: address <= 3'b110;
		3'b111: address <= 3'b111;
	endcase
end

// Output Z
always @(address or Q) begin
	case (address)
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
