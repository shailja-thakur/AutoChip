module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0000000000; // Reset count to zero
        end else if (q == 999) begin
            q <= 10'b0000000000; // Reset count to zero when it reaches 999
        end else begin
            q <= q + 1; // Increment count
        end
    end
endmodule
