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
    if (L)
        temp <= R;
    else if (E)
        temp <= w;
end

assign Q = temp;

endmodule
