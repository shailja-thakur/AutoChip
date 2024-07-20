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
            // Reset Q to 0 when R is high
            Q <= 1'b0;
        end
        else if (L) begin
            // Update Q with the value of R when L is high
            Q <= R;
        end
        else if (~E) begin
            // Hold the current state of Q when E is low
            Q <= Q;
        end
        else begin
            // Update Q with the value of w when L is low and E is high
            Q <= w;
        end
    end

endmodule
