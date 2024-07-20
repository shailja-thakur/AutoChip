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
        Q <= 0; // Reset output to low state
    else if (E) begin
        if (L)
            Q <= 0; // Update Q with 0 if L is high (reset condition)
        else
            Q <= w; // Update Q with w if L is low
    end
end

endmodule
