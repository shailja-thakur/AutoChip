module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        q <= {q[2:0], data};
    end
    else if (count_ena) begin
        q <= q - 1'b1;
    end
    // No change to q if neither shift_ena nor count_ena is active
end

endmodule
