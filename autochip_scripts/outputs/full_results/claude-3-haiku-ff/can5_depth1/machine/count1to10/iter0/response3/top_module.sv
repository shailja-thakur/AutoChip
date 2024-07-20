module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'd1; // Reset to 1 when reset is active
    end else begin
        if (q == 4'd10) begin
            q <= 4'd1; // Reset to 1 when q reaches 10
        end else begin
            q <= q + 1; // Increment q by 1 when reset is not active
        end
    end
end

endmodule
