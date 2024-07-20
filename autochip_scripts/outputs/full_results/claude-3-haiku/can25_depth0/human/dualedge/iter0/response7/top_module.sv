module top_module(
    input clk,
    input d,
    output reg q
);

reg q_pos, q_neg;

always @(posedge clk) begin
    q_pos <= d;
end

always @(negedge clk) begin
    q_neg <= d;
end

always @(*) begin
    case ({clk, q_pos, q_neg})
        3'b100: q <= q_pos;
        3'b011: q <= q_neg;
        default: q <= q;
    endcase
end

endmodule
