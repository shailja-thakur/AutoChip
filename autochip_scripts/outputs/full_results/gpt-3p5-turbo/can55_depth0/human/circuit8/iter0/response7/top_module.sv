module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg p_temp, q_temp;

always @(posedge clock) begin
    p_temp <= a & p_temp;
    q_temp <= p_temp & q_temp;
end

always @(negedge clock) begin
    p <= p_temp;
    q <= q_temp;
end

endmodule
