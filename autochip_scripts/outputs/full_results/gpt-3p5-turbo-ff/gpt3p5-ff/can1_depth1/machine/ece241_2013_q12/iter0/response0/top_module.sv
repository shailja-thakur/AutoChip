module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] q;
wire [2:0] addr;
wire [7:0] shifted_q;

assign addr = A + B + C;

always @(posedge clk) begin
	if (enable) begin
		q <= {q[6:0], S};
	end
end

assign shifted_q = q << S;

always @(addr, shifted_q) begin
	case (addr)
		3'b000: Z <= shifted_q[0];
		3'b001: Z <= shifted_q[1];
		3'b010: Z <= shifted_q[2];
		3'b011: Z <= shifted_q[3];
		3'b100: Z <= shifted_q[4];
		3'b101: Z <= shifted_q[5];
		3'b110: Z <= shifted_q[6];
		3'b111: Z <= shifted_q[7];
	endcase
end

endmodule
