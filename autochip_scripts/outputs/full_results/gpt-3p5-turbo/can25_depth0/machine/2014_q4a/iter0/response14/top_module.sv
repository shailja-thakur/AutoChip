module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    always @(posedge clk) begin
        if (E == 0) begin
            Q <= Q;  // Hold Q in its current state
        end else begin
            if (L == 1) begin
                Q <= R;  // Update Q with R
            end else begin
                Q <= w;  // Update Q with w
            end
        end
    end
endmodule
