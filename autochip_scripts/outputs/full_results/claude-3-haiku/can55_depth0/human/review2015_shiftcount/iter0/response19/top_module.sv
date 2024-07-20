module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift in new data from LSB to MSB
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        // Decrement the 4-bit value
        q <= q - 1;
    end
    // else, keep the current value of q
end

endmodule
