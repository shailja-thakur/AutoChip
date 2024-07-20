module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg p_reg;

always @(posedge clock) begin
    p_reg <= a;
end

always @(posedge clock) begin
    if (p_reg == 1'b1) begin
        q <= 1'b0;
    end else begin
        q <= 1'b1;
    end
end

always @(posedge clock) begin
    p <= p_reg;
end

endmodule
