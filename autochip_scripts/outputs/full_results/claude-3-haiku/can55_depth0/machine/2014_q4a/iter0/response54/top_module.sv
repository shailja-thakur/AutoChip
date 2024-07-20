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
            // Hold current state of Q
        end
        else if (L) begin
            // Update Q with the value of R
            Q <= R;
        end
        else begin
            // Update Q with the value of w
            Q <= w;
        end
    end

endmodule
