module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 1; // Reset the counter to 1
    end
    else begin
        if (q == 10) begin
            q <= 1; // Wrap around to 1 when reaching 10
        end
        else begin
            q <= q + 1; // Increment the counter
        end
    end
end

endmodule
