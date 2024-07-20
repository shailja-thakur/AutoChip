module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg p_s, q_s;

always@(posedge clock) begin
    p_s <= a & ~p_s;
    q_s <= p & ~q_s;
end

always@(posedge clock) begin
    p <= p_s;
    q <= q_s;
end

endmodule
