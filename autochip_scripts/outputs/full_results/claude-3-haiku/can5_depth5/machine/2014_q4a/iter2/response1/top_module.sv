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
        Q <= 1'b0; // Reset the output to 0 when R is high
    end
    else if (~E) begin
        // Hold the current value of Q when E is low
        // No need to assign Q <= Q; since this is the default behavior
    end
    else if (L) begin
        Q <= R; // Assign R to Q when L is high
    end
    else begin
        Q <= w; // Assign w to Q when L is low
    end
end

endmodule
