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
        Q <= 1'b0;           // Reset the register to 0 if R is high
    else if (E) begin
        if (L)
            Q <= R;         // Update the register with value of R if L is high
        else
            Q <= w;         // Update the register with value of w if L is low
    end
    // If E is low, output Q is held in its current state
end

endmodule
