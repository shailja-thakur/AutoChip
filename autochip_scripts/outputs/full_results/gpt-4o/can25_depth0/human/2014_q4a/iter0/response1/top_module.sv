module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk) begin
        if (L) // Load value R
            Q <= R;
        else if (E) // Shift w into the register
            Q <= w;
    end

endmodule
