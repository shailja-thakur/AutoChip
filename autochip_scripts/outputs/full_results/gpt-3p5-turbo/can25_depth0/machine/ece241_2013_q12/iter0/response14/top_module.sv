module top_module (
	input clk,
	input enable,
	input S,
	input [2:0] A,
	input [2:0] B,
	input [2:0] C,
	output Z
);
	
	reg [7:0] q;
	wire [2:0] addr;
	
	assign addr = A + B + C;
	assign Z = q[addr];
	
	always @(posedge clk) begin
		if (enable)
			q <= {S, q[7:1]};
	end
	
endmodule
