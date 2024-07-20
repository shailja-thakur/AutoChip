module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'd0;     // Reset counter to 0
        end else begin
            if (q == 10'd999) begin
                q <= 10'd0; // Reset counter to 0 when it reaches 999
            end else begin
                q <= q + 1;  // Increment counter by 1
            end
        end
    end
endmodule
