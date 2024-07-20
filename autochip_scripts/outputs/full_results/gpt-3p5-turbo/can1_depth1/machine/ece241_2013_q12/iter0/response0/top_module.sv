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
reg [2:0] address;

always @(posedge clk) begin
	if (enable) begin
		q <= {q[6:0], S};
	end
end

always @* begin
	address = A << 2 | B << 1 | C;
end

assign Z = q[address];

endmodule
