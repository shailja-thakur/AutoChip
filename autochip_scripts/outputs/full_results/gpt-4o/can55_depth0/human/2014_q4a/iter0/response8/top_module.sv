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
            Q <= R;  // Load value R when L is asserted
        end else if (E) begin
            Q <= w; // Shift value w when E is asserted
        end
    end
endmodule
