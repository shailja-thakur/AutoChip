module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] next_q;

	// Counter logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			next_q <= 4'b0000;
		end else begin
			if (slowena) begin
				if (q == 4'b1001) begin
					next_q <= 4'b0000;
				end else begin
					next_q <= q + 1;
				end
		
			else begin
				next_q <= q;
			end
		end
	end

	// Output logic
	always @(*) begin
		q <= next_q;
	end

endmodule
