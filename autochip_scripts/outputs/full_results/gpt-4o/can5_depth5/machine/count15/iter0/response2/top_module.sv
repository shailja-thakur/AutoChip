module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of clk or when reset is asserted
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end else begin
            q <= q + 1; // Increment the counter by 1
        end
    end

endmodule
