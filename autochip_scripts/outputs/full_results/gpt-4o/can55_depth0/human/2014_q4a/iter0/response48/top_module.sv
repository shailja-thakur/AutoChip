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
        Q <= R;          // Load the value R when L is asserted
    else if (E)
        Q <= w;          // Shift the value of w when E is enabled
end

endmodule
