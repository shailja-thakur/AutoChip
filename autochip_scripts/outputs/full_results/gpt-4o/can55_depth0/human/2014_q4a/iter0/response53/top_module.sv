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
            Q <= R; // Load the value R if L is asserted
        else if (E)
            Q <= w; // Shift the value w if E is asserted
        // Otherwise, Q retains its value.
    end

endmodule
