module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'd1; // Reset counter to 1
    end
    else begin
        if (q == 4'd10) // Check if counter has reached 10
            q <= 4'd1; // Reset counter to 1
        else
            q <= q + 1; // Increment counter
    end
end

endmodule
