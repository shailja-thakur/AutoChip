module top_module(
    input clk,
    input d,
    output reg q
);

reg q_neg;

always @(posedge clk) begin
    q <= d;
    q_neg <= q;
end

always @(negedge clk) begin
    q <= d;
    q_neg <= q;
end

always @(*) begin
    if (q != q_neg)
        q = q;
    else
        q = d;
end

endmodule
