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
            Q <= 1'b0; // Clear output to low state if L is high
        else
            Q <= w; // Update Q with w if L is low
    end
end

endmodule
