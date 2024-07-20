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
        Q <= 1'b0;  // Reset the register to 0 when R is high
    else if (E) begin
        if (L)
            Q <= R;  // Update Q with R when L is high
        else
            Q <= w;  // Update Q with w when L is low
    end
    // When E is low, Q is held in its current state
end

endmodule
