module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift in the new data from the MSB
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        // Decrement the counter
        q <= q - 1;
    end
    // If both shift_ena and count_ena are 0, the register value remains unchanged
end

endmodule
