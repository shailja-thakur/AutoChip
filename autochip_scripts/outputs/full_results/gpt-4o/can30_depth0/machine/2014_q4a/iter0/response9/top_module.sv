module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R) begin
        Q <= 0; // Reset Q to 0 when R is high
    end else if (E) begin
        if (L)
            Q <= R; // Update Q with R when L is high
        else
            Q <= w; // Update Q with w when L is low
    end
    // If E is low, Q maintains its current state
end

endmodule
