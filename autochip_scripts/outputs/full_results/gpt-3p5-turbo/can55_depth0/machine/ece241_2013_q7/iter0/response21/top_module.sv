module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j && k) begin
        Q <= ~Q; // Toggle Q when both j and k are high
    end else if (~j && k) begin
        Q <= 0; // Reset Q to 0 when j is low and k is high
    end else if (j && ~k) begin
        Q <= j; // Set Q to j when j is high and k is low
    end
end

endmodule
