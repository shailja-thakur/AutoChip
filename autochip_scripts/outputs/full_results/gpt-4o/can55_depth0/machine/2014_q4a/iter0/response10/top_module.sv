module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    always @(posedge clk) begin
        if (R) begin
            Q <= 1'b0;  // Reset Q to 0 if R is high
        end 
        else if (E) begin
            if (L) begin
                Q <= R;  // Update Q with value of R if L is high
            end 
            else begin
                Q <= w;  // Update Q with value of w if L is low
            end
        end
        // If E is low, Q will hold its current value automatically
    end
endmodule
