module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    always @(posedge clk) begin
        if (R)
            Q <= 1'b0;         // Reset logic: When R is high, Q is reset to 0
        else if (E)
            Q <= L ? R : w;    // Enable logic and update Q based on L: 
                              // When L is high, Q is updated with R
                              // When L is low, Q is updated with w
    end
endmodule
