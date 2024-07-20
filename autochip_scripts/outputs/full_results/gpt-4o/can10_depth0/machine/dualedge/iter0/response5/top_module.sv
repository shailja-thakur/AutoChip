module top_module(
    input clk,
    input d,
    output reg q
);

reg qp, qn;

always @(posedge clk) begin
    qp <= d;
end

always @(negedge clk) begin
    qn <= d;
end

always @(*) begin
    q = (clk) ? qp : qn;
end

endmodule
