module top_module (
    input wire clk,
    input wire j,
    input wire k,
    output reg Q
);
 
    always @(posedge clk) begin
        if (j == 1'b0 && k == 1'b1)
            Q <= 1'b0;           // Reset output Q
        else if (j == 1'b1 && k == 1'b0)
            Q <= 1'b1;           // Set output Q
        else if (j == 1'b1 && k == 1'b1)
            Q <= ~Q;             // Toggle output Q
        // Else case for when j == 0 and k == 0, Q remains unchanged
    end

endmodule
