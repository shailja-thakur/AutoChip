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
        if (L) begin
            D <= R;
        end else begin
            D <= w;
        end
    end
    Q <= D;
end

endmodule
