module top_module(
    input clk,
    input d,
    output reg q
);

// Create a register that stores the previous clock value
reg clk_prev;

always @(posedge clk) begin
    // Store the previous clock value
    clk_prev <= clk;
    
    // Detect both positive and negative edges of the clock
    if (clk && !clk_prev) begin
        // Positive edge
        q <= d;
    end
    else if (!clk && clk_prev) begin
        // Negative edge
        q <= d;
    end
end

endmodule
