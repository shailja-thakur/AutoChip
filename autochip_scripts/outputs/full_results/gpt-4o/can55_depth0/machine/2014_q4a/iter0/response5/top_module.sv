module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R) 
        Q <= 1'b0; // Reset Q to low when R is high
    else if (E) 
        if (L) 
            Q <= R; // When L is high and E is enabled, Q is updated with R (which should be 0 due to reset).
        else 
            Q <= w; // When L is low and E is enabled, Q is updated with w
end

endmodule
