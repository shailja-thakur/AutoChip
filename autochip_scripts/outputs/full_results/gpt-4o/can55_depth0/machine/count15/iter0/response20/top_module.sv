module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Initial block to define the initial value of q
    initial begin
        q = 4'b0000;
    end

    // Always block triggered on the rising edge of clk
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end else begin
            q <= q + 1; // Increment the counter by 1
        end
    end
endmodule
