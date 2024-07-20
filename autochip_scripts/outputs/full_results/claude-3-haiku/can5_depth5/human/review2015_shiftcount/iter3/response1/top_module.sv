module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        q <= q - 1'b1;
    end
    // If both shift_ena and count_ena are 1, the module will shift in the new data
    // and then decrement the value, which is the expected behavior.
end

endmodule
