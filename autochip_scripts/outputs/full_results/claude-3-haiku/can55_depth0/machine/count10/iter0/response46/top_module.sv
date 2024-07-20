module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset || q == 4'b1001) begin // 9 in binary
        q <= 4'b0000; // Reset counter to 0
    end
    else begin
        q <= q + 4'b0001; // Increment counter
    end
end

endmodule
