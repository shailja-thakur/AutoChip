module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg p_reg;
reg q_reg;

always @(posedge clock) begin
    p_reg <= p;
    q_reg <= q;
end

always @(posedge clock) begin
    if (a == 1'b0) begin
        p <= 1'b0;
        q <= 1'b0;
    end else begin
        p <= p_reg;
        q <= q_reg;
    end
end

endmodule
