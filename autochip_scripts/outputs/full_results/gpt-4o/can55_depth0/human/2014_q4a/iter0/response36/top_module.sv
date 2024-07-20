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
            Q <= R;           // Load operation
        else if (E)
            Q <= w;           // Shift operation
        // Else, retain the current value of Q
    end
    
endmodule
