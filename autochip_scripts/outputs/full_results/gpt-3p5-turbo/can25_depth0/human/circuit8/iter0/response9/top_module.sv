module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg tmp_p, tmp_q;

always @(posedge clock) begin
    tmp_p <= a;
    tmp_q <= tmp_p;
end

always @(posedge clock) begin
    if (clock)
        {p, q} <= {tmp_q, p};
end

endmodule
