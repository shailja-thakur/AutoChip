module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 10'b0; // Reset the counter to 0
        else if (q == 10'd999)
            q <= 10'b0; // Reset the counter when it reaches 999
        else
            q <= q + 10'b1; // Increment the counter
    end

endmodule
