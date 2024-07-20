module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

    // Initial block to reset q at startup
    initial begin
        q = 4'b0000;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter to 0
        end
        else begin
            q <= q + 4'b0001; // Increment counter by 1
        end
    end

endmodule
