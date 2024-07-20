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
        Q <= 0; // Reset output to low state
    else if (E) begin
        if (L)
            Q <= 1; // Assuming L high means setting Q to 1 (controlled state)
        else
            Q <= w; // Update Q with w if L is low
    end
    // If E is low, Q holds its value (no need for an explicit condition)
end

endmodule
