module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk or posedge R) begin
    if (R) begin
        Q <= 0;  // Reset Q to a known state
    end
    else if (E) begin
        if (L) begin
            Q <= R;  // Update Q with the value of R when L is high
        end
        else begin
            Q <= w;  // Update Q with the value of w when L is low
        end
    end
    // When E is low, Q is held in its current state; no need for explicit else
end

endmodule
