module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'd0; // Reset the counter to 0
        end else if (q == 10'd999) begin
            q <= 10'd0; // Reset the counter to 0 when it reaches 999
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
endmodule
