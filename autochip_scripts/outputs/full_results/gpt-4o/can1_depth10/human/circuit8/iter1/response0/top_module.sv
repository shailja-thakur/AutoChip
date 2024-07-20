module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg q_next;

always @(posedge clock) begin
    if (a == 1)
        p <= 1;
    else
        p <= 0;
end

always @(negedge clock) begin
    q <= q_next;
end

always @(*) begin
    if (a == 1)
        q_next = 1;
    else
        q_next = p;
end

endmodule
