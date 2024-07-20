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
        Q <= 1'b0; // Reset output to low state
    end else if (E) begin
        if (L)
            Q <= R; // Update Q with R if L is high
        else
            Q <= w; // Update Q with w if L is low
    end
    // If E is low, Q retains its previous state (no need for an explicit else)
end

endmodule
