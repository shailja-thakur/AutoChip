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
            // Hold current state
            Q <= Q;
        end
        else if (L) begin
            // Update with R
            Q <= R;
        end
        else begin
            // Update with w
            Q <= w;
        end
        
        // Reset to 0 if R is high
        if (R) begin
            Q <= 1'b0;
        end
    end

endmodule
