module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift the data input into the 4-bit register
        q <= {q[2:0], data};
    end
    else if (count_ena) begin
        // Decrement the 4-bit register
        q <= q - 1;
    end
    // If both enable signals are low, do nothing
end

endmodule
