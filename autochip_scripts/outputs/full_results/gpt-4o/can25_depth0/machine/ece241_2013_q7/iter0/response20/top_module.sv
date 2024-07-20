module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b0 && k == 1'b0)
        // Q remains the same
        Q <= Q;
    else if (j == 1'b0 && k == 1'b1)
        // Reset the Q to 0
        Q <= 1'b0;
    else if (j == 1'b1 && k == 1'b0)
        // Set the Q to 1
        Q <= 1'b1;
    else if (j == 1'b1 && k == 1'b1)
        // Toggle the Q
        Q <= ~Q;
end

endmodule
