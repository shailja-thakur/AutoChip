module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift in data from the most significant bit
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        // Decrement the number in the register
        q <= q - 1;
    end
end

endmodule
