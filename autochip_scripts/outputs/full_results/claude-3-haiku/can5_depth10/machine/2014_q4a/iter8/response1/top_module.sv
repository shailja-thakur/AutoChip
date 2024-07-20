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
            Q <= 1'b0;
        end
        else if (~E) begin
            // When E is low, the output Q is held in its current state.
            // So, we should not update the value of Q.
            // Instead, we should keep the previous value of Q.
            // Q <= Q;
        end
        else if (L) begin
            // When L is high, the output Q is updated with the value of R.
            Q <= R;
        end
        else begin
            // When L is low, the output Q is updated with the value of w.
            Q <= w;
        end
    end

endmodule
