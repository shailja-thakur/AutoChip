module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift in new data from most-significant-bit
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        // Decrement the counter
        q <= q - 1'b1;
    end
    // If both shift_ena and count_ena are 1, the module will shift in new data and decrement the counter, which is the desired behavior.
end

endmodule
