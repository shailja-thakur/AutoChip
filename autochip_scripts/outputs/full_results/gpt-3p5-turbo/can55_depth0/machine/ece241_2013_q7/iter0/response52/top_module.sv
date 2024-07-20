module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

// Sequential logic
always @(posedge clk) begin
    if (j && k) begin
        Q <= ~Q; // Toggle Q when j and k are both high
    end else if (~j && k) begin
        Q <= 1'b0; // Reset Q when j is low and k is high
    end else if (j && ~k) begin
        Q <= 1'b1; // Set Q to j when j is high and k is low
    end
    // Q remains unchanged when both j and k are low
end

endmodule
