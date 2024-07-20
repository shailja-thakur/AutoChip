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
            Q <= R;       // Load value R into Q
        else if (E)
            Q <= w;       // Shift value w into Q
    end

endmodule
