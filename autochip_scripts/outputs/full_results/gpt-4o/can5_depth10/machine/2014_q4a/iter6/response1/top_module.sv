module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk or posedge R) begin
    if (R)
        Q <= 1'b0; // Reset output to low state
    else if (E) begin
        if (L)
            Q <= 1'b0; // Update Q with 0 if L is high (since L and R have the same effect)
        else
            Q <= w; // Update Q with w if L is low
    end    
end

endmodule
