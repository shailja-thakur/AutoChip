module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R; // Load the register with value R if L is asserted
        end else if (E) begin
            Q <= w; // Shift the register with input w if E is asserted
        end
    end
endmodule
