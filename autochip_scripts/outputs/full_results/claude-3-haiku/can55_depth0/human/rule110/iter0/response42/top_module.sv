module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q
);

always @(posedge clk) begin
	if (load) begin
		q <= data;
	end
	else begin
		// Compute the next state for each cell based on the Rule 110 logic
		for (int i = 0; i < 512; i++) begin
			q[i] <= (q[(i-1)%512] & q[(i)%512] & ~q[(i+1)%512]) |
			        (q[(i-1)%512] & ~q[(i)%512] & q[(i+1)%512]) |
			        (~q[(i-1)%512] & q[(i)%512] & q[(i+1)%512]) |
			        (~q[(i-1)%512] & ~q[(i)%512] & ~q[(i+1)%512]);
		end
	end
end

endmodule
