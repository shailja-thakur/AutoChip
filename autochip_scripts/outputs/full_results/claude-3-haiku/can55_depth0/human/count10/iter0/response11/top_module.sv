module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset the counter to 0
    end
    else begin
        if (q == 4'b1001) // Check if the counter has reached 9
            q <= 4'b0000; // Reset the counter to 0
        else
            q <= q + 1'b1; // Increment the counter
    end
end

endmodule
