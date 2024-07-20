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
    else if (E)
        if (L)
            Q <= 1; // Update Q with logic 1 if L is high (based on description)
        else
            Q <= w; // Update Q with w if L is low
end

endmodule
