module top_module (
	input clk,
	input enable,
	input S,
	input [2:0] A,
	input [2:0] B,
	input [2:0] C,
	output reg Z
);
	
	reg [7:0] q;
	reg [2:0] addr;
	
	always @(posedge clk) begin
		if (enable) begin
			if (S) begin
				q <= {S, q[7:1]};
			end
		end
	end
	
	always @(A or B or C) begin
		addr <= A | B | C;
		Z <= q[addr];
	end
	
endmodule
