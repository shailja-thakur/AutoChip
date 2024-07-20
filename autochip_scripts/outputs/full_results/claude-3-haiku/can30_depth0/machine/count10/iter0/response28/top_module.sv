module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset || q == 4'b1001) begin // Reset the counter to 0 if reset is asserted or the count reaches 9 (4'b1001)
        q <= 4'b0000;
    end
    else begin
        q <= q + 1'b1; // Increment the counter by 1
    end
end

endmodule
