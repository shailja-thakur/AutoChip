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
            Q <= 1'b0; // Reset the output to 0
        end
        else if (E) begin
            if (L) begin
                Q <= R; // Update output with the value of R
            end
            else begin
                Q <= w; // Update output with the value of w
            end
        end
        else begin
            Q <= Q; // Hold the current value of Q
        end
    end

endmodule
