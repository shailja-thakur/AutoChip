module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);
    always @(posedge clk) begin
        if (j == 1'b0 && k == 1'b0) begin
            // Q retains its value
            Q <= Q;
        end else if (j == 1'b0 && k == 1'b1) begin
            // Reset Q to 0
            Q <= 1'b0;
        end else if (j == 1'b1 && k == 1'b0) begin
            // Set Q to 1
            Q <= 1'b1;
        end else if (j == 1'b1 && k == 1'b1) begin
            // Toggle Q
            Q <= ~Q;
        end
    end
endmodule
