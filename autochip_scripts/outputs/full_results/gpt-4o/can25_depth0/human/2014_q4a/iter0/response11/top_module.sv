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
            Q <= R;         // Load value R into the register when L is high.
        else if (E)
            Q <= w;         // Shift input w into the register when E is high.
    end

endmodule
