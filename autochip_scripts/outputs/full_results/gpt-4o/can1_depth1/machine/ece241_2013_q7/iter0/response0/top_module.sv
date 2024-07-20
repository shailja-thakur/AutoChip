module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);
    always @(posedge clk) begin
        if (j == 1 && k == 0) begin
            Q <= 1;  // Set Q to 1
        end else if (j == 0 && k == 1) begin
            Q <= 0;  // Reset Q to 0
        end else if (j == 1 && k == 1) begin
            Q <= ~Q;  // Toggle Q
        end
        // When j and k are both 0, Q remains unchanged
    end
endmodule
