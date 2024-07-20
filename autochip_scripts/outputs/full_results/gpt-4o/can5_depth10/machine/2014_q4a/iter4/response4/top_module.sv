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
        Q <= 0; // Reset output to low state if R is high
    else if (E) begin
        if (L)
            Q <= R; // This line seems redundant since R was already checked. Updating it to hold its state might be better
        else
            Q <= w; // Update Q with w if L is low
    end
end

endmodule
