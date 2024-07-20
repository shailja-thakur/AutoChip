module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_ff;
reg q_ff;

always @(posedge clock) begin
    p_ff <= a;
    q_ff <= p_ff;
end

always @(posedge clock or negedge clock) begin
    if (~a)
        p <= p_ff;
    else
        p <= 0;

    q <= q_ff;
end

endmodule
