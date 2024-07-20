module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] d_ff [7:0];
	always @(negedge clk) begin
		if (reset)
			q <= 8'b00110100;
		else begin
			for (int i = 0; i < 8; i=i+1)
    			d_ff[i] <= d[i];
    		q <= {d_ff[7], d_ff[6], d_ff[5], d_ff[4], d_ff[3], d_ff[2], d_ff[1], d_ff[0]};
    	end
	end
endmodule
