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
            Q <= R; // Update Q with value of R if L is high
        else
            Q <= w; // Update Q with value of w if L is low
    end
end

endmodule
