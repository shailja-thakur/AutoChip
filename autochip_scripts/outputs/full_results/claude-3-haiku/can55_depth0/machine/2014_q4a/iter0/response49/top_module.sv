module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (~E) begin
        // Hold the current state of Q
        // No update to Q
    end
    else if (L) begin
        // Update Q with the value of R
        Q <= R;
    end
    else begin
        // Update Q with the value of w
        Q <= w;
    end

    // If R is high, reset Q to 0
    if (R) begin
        Q <= 1'b0;
    end
end

endmodule
