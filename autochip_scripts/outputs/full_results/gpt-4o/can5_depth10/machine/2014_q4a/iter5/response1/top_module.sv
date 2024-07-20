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
        Q <= 0; // Reset output to low state when R is high
    else if (E) begin
        if (L)
            Q <= w; // Update Q with w if L is high
        else
            Q <= Q; // Hold current state of Q if L is low
    end
end

endmodule
