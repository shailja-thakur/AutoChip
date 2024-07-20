module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 4'b0; // Reset the counter to 0
    else begin
        if (q == 4'd9)
            q <= 4'b0; // Reached the maximum count, reset to 0
        else
            q <= q + 1'b1; // Increment the counter
    end
end

endmodule
