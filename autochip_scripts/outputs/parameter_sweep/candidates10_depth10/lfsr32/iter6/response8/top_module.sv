module lfsr32(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] next_q;
	reg [3:0] taps;

	always @(posedge clk) begin
		if (reset) begin
			next_q <= 32'h1;
		end else begin
			next_q[31:1] <= q[30:0];
			next_q[0] <= q[22]^q[2]^q[1]^q[0];
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= next_q;
		end
	end
	
	initial begin
		taps <= 4'b1001;
	end

endmodule
