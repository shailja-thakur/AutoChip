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
        q <= (q == 4'b1111) ? 4'b0000 : q + 1'b1; // Increment the counter or reset to 0
    end
end

endmodule
