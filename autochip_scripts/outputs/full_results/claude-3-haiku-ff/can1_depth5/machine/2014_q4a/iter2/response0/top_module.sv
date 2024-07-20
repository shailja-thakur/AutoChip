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
        // Reset the output Q to 0
        Q <= 1'b0;
    end
    else if (~E) begin
        // Hold the current state of Q
        Q <= Q;
    end
    else if (L) begin
        // Update Q with the value of R
        Q <= 1'b0;
    end
    else begin
        // Update Q with the value of w
        Q <= w;
    end
end

endmodule
