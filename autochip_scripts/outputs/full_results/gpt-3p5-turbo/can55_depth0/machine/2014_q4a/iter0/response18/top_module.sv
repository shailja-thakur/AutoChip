module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E == 1) begin
        if (L == 1)
            Q <= R;
        else
            Q <= w;
    end
end

always @(posedge clk) begin
    if (R == 1)
        Q <= 0;
end

endmodule
