module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b1 && k == 1'b0) begin
        Q <= 1'b1;  // Set Q to 1
    end
    else if (j == 1'b0 && k == 1'b1) begin
        Q <= 1'b0;  // Reset Q to 0
    end
    else if (j == 1'b1 && k == 1'b1) begin
        Q <= ~Q;  // Toggle Q
    end
    // else case: when j == 0 and k == 0, Q remains unchanged
end

endmodule
