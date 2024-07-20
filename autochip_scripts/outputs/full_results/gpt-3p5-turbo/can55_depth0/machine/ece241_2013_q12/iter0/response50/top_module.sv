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

always @(posedge clk)
begin
	if (enable)
	begin
		q <= q << 1;
		q[0] <= S;
	end
	
	address <= {A, B, C};
	Z <= q[address];
end

endmodule
