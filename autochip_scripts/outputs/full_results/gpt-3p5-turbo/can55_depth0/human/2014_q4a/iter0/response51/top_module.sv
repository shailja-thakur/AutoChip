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
        D <= L ? R : w;
    end
    Q <= D;
end

endmodule
