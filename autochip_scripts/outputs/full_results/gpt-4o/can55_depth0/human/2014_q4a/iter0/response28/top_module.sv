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
            Q <= R;           // Load R into Q when L is asserted
        else if (E)
            Q <= w;           // Shift w into Q when E is enabled
    end

endmodule
