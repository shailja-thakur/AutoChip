module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

// Internal counter signal
reg [3:0] count;

always @(posedge clk) begin
	if (reset) begin
		count <= 4'b0001; // Reset the counter to 1
	end else begin
		if (count == 4'b1010) begin // If count is 10, wrap around to 1
			count <= 4'b0001;
		end else begin
			count <= count + 1; // Increment the counter
		end
	end
end

assign q = count;

endmodule
