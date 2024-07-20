module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg temp;

always @(posedge clk) begin
    if (E) begin
        temp <= L ? R : Q;
        Q <= w;
    end
end

endmodule
