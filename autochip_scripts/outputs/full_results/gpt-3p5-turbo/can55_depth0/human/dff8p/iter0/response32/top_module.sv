module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_dffs [0:7];

	always @(negedge clk or posedge reset)
	begin
		if (reset)
		begin
			q_dffs <= 8'b00110100;
		end
		else
		begin
			for (int i=0; i<8; i=i+1)
			begin
				q_dffs[i] <= d[i];
			end
		end
	end
	
	assign q = q_dffs;
endmodule
