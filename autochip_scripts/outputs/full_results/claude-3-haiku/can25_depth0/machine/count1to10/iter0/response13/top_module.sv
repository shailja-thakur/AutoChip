module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset to 1 instead of 0
    end
    else begin
        q <= (q == 4'b1010) ? 4'b0001 : q + 1; // Correctly reset to 1 when q reaches 10
    end
end

endmodule
