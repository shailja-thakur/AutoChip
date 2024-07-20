module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg D;

always @(posedge clk) begin
    if (E) begin
        D <= R;
    end else if (L) begin
        D <= w;
    end else begin
        D <= Q;
    end
end

always @(posedge clk) begin
    if (L) begin
        Q <= w;
    end else begin
        Q <= D;
    end
end

endmodule
