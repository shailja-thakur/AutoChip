module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk) begin
        if (L) // Load mode
            Q <= R;
        else if (E) // Shift mode
            Q <= w;
    end

endmodule
