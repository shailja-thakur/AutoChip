module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (!E) begin
        // Hold the current state of Q if E is low
        Q <= Q;
    end
    else if (L) begin
        // Update Q with the value of R if L is high
        Q <= R;
    end
    else begin
        // Update Q with the value of w if L is low
        Q <= w;
    end
end

endmodule
