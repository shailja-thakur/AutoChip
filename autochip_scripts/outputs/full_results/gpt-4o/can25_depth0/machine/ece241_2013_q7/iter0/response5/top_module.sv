module top (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1 && k == 0) begin
        Q <= 1; // Set
    end else if (j == 0 && k == 1) begin
        Q <= 0; // Reset
    end else if (j == 1 && k == 1) begin
        Q <= ~Q; // Toggle
    end
    // When j == 0 and k == 0, Q remains unchanged
end

endmodule
