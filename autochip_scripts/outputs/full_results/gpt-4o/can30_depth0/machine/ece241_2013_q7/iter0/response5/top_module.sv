module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b0 && k == 1'b0) begin
        // No change condition
        Q <= Q;
    end
    else if (j == 1'b0 && k == 1'b1) begin
        // Reset condition
        Q <= 1'b0;
    end
    else if (j == 1'b1 && k == 1'b0) begin
        // Set condition
        Q <= 1'b1;
    end
    else if (j == 1'b1 && k == 1'b1) begin
        // Toggle condition
        Q <= ~Q;
    end
end

endmodule
