module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

// At each clock tick, increment the counter or reset it to 0 if reset is high
always @(posedge clk) begin
    if (reset) begin
        q <= 10'd0; // Reset the counter to 0
    end else begin
        if (q == 10'd999) begin
            q <= 10'd0; // Reset the counter when it reaches 999
        end else begin
            q <= q + 10'd1; // Increment the counter
        end
    end
end

endmodule
