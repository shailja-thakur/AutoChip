module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_prev, q_prev;

always @(posedge clock) begin
    p_prev <= a;
    q_prev <= p_prev;
    p <= a & ~q_prev;
    q <= a | q_prev;
end

endmodule
