module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
    p_temp <= a;
    q_temp <= p_temp;
end

always @(posedge clock) begin
    if (clock) begin
        p <= p_temp;
        q <= q_temp;
    end
end

endmodule
