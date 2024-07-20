module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (L)
        Q <= R;       // Load R into the register
    else if (E)
        Q <= w;       // Shift in the new bit w
end

endmodule
