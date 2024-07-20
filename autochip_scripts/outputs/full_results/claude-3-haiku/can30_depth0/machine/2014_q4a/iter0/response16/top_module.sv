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
            Q <= 1'b0; // Reset the output to 0 when R is high
        end
        else if (~E) begin
            // Hold the output in its current state when E is low
            // No change to Q
        end
        else if (L) begin
            Q <= R; // Update the output with the value of R when L is high
        end
        else begin
            Q <= w; // Update the output with the value of w when L is low
        end
    end

endmodule
