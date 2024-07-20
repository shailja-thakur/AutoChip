module top (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b0 && k == 1'b0) begin
        // No change in Q when both j and k are 0
        Q <= Q; 
    end
    else if (j == 1'b0 && k == 1'b1) begin
        // Reset Q when j is 0 and k is 1
        Q <= 1'b0;
    end
    else if (j == 1'b1 && k == 1'b0) begin
        // Set Q when j is 1 and k is 0
        Q <= 1'b1;
    end
    else if (j == 1'b1 && k == 1'b1) begin
        // Toggle Q when both j and k are 1
        Q <= ~Q;
    end
end

endmodule
