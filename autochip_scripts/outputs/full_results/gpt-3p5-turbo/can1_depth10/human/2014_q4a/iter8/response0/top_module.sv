module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg Q_reg;

always @(posedge clk) begin
    if (E) begin
        if (L)
            Q_reg <= R;
        else if (Q_reg == 1'b1)
            Q_reg <= w;
        else
            Q_reg <= Q_reg;
    end
    else if (L)
        Q_reg <= 1'b0;
end

always @(posedge clk) begin
    Q <= Q_reg;
end

endmodule
