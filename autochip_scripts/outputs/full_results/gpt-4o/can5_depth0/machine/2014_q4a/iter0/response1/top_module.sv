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
        Q <= 1'b0; // Reset the output Q to low state when R is high
    end else if (E) begin
        if (L) begin
            Q <= R; // Update Q with the value of R when L is high
        } else begin
            Q <= w; // Update Q with the value of w when L is low
        end
    end
    // If E is low, Q holds its current state
end

endmodule
