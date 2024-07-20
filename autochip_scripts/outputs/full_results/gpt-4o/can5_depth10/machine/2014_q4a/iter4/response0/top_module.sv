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
        Q <= 0; // Reset output to low state when R is high
    else if (E) begin
        if (L)
            Q <= 1; // Update Q with 1 if L is high (since we don't have the actual data of R here we assume it should set Q to high as stated)
        else
            Q <= w; // Update Q with w if L is low
    end
    // If E is low, Q is held in its current state
end

endmodule
