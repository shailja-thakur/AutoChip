module top_module(
    input clk,
    input reset,
    output reg [9:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0; // Reset the counter to 0
    end
    else begin
        if (q == 999) begin
            q <= 0; // Wrap around to 0 when reaching 999
        end
        else begin
            q <= q + 1; // Increment the counter
        end
    end
end

endmodule
