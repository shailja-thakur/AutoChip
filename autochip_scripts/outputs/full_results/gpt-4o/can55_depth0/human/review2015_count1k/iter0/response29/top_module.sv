module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'd0;     // Reset the counter to 0
        end else begin
            q <= (q == 10'd999) ? 10'd0 : q + 10'd1;   // Count from 0 to 999
        end
    end

endmodule
