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
            Q <= 1'b0; // Reset
        end else if (E) begin
            if (L) begin
                Q <= R; // Load R
            end else begin
                Q <= w; // Load w
            end
        end
        // If E is low, Q holds its current state
    end
endmodule
