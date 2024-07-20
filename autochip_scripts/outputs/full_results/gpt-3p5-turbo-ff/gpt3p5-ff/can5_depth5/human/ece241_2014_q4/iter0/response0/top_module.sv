module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;
wire nq1, nq2, nq3;

xor gate1 (x, q1, d1);
and gate2 (x, nq2, d2);
or gate3 (x, nq3, d3);

xnor gate4 (q1, q2, q3, z);

always@(posedge clk) begin
    if (reset) begin
        d1 <= 0;
        d2 <= 0;
        d3 <= 0;
    end else begin
        d1 <= q1;
        d2 <= ~q2;
        d3 <= ~q3;
    end
end

endmodule
