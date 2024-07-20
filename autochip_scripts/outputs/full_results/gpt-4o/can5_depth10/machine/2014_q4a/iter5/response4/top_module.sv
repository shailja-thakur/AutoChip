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
            Q <= R; // This line does not look correct, Update Q with R if L is high
        else
            Q <= w; // Update Q with w if L is low
    end
end

endmodule
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
            Q <= 1; // Update Q with high if L is high (since the description says update with the value of R when L is high, it should be setting Q to high)
        else
            Q <= w; // Update Q with w if L is low
    end
end

endmodule
