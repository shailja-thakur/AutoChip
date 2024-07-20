module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 4'd0; // Reset counter to 0
    else
        q <= (q == 4'd9) ? 4'd0 : q + 1'd1; // Increment counter, wrap around to 0 at 9
end

endmodule
