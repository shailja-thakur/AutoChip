module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b0 && k == 1'b1)
        Q <= 1'b0; // Reset
    else if (j == 1'b1 && k == 1'b0)
        Q <= 1'b1; // Set
    else if (j == 1'b1 && k == 1'b1)
        Q <= ~Q; // Toggle
    // if both j and k are 0, Q remains unchanged
end

endmodule
