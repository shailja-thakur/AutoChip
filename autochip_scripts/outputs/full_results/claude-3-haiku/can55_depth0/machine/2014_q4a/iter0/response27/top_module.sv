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
            // Hold current state if E is low
            Q <= Q;
        end
        else if (L) begin
            // Update output with R if L is high
            Q <= R;
        end
        else begin
            // Update output with w if L is low
            Q <= w;
        end
    end

endmodule
