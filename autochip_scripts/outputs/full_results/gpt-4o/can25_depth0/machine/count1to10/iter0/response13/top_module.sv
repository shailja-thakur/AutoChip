module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

    // Initialize the output register
    initial q = 4'd1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'd1;  // Reset output register to 1
        end
        else if (q == 4'd10) begin
            q <= 4'd1;  // Reset to 1 when q reaches 10
        end
        else begin
            q <= q + 1;  // Increment q by 1
        end
    end
endmodule
