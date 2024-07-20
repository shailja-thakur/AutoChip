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
        Q <= 1'b0; // Reset the register to 0 when R is high
    end
    else if (E) begin
        if (L) begin
            Q <= R; // Update Q with the value of R when L is high
        end
        else begin
            Q <= w; // Update Q with the value of w when L is low
        end
    end
    // If E is low, hold the current state of Q
end

endmodule
