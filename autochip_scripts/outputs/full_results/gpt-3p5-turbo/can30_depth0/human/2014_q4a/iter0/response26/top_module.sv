module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg D;
wire S;

always @(posedge clk) begin
    if (E) begin
        if (L)
            D <= R;
        else
            D <= Q;
    end
    else begin
        D <= Q;
    end
end

assign S = E ? L : 1'b0;

always @(posedge clk) begin
    if (S)
        Q <= w;
    else
        Q <= D;
end

endmodule
