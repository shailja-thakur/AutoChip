module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset the counter to 0 on active high synchronous reset
    end
    else begin
        if (q == 4'b1001) begin // Reached 9, reset to 0
            q <= 4'b0000;
        end
        else begin
            q <= q + 1'b1; // Increment the counter
        end
    end
end

endmodule
