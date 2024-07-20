module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk) begin
        // Multiplexer and flip-flop logic implementation
        if (L) 
            Q <= R;     // Load R into Q when L is asserted
        else if (E) 
            Q <= w;     // Shift in w when E is enabled
        // Else, retain the current value of Q
    end

endmodule
