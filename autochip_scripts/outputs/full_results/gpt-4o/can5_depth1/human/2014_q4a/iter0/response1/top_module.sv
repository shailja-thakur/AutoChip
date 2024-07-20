module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= R;         // Load the value R if L is asserted
    end
    else if (E) begin
        Q <= w;         // Shift the value w if E is enabled and L is not asserted
    end
end

endmodule
