module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk) begin
        if (L)
            Q <= R; // Load value R if L is asserted
        else if (E)
            Q <= w; // Shift in the value of w if E is enabled
    end

endmodule
