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
        Q <= 0; // Reset the register to low state
    end else if (E) begin
        if (L) begin
            Q <= R; // Update Q with R if L is high
        } else begin
            Q <= w; // Update Q with w if L is low
        end
    end
    // If E is low, Q is held in its current state
end

endmodule
