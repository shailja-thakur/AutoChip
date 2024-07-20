module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset the counter to 1
    end
    else begin
        if (q == 4'b1010) // Reached 10
            q <= 4'b0001; // Reset to 1
        else
            q <= q + 1; // Increment the counter
    end
end

endmodule
