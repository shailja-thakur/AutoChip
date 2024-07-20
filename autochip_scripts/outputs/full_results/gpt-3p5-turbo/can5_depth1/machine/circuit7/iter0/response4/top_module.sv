module top_module (
    input clk,
    input a, 
    output reg q
);
    
always @(posedge clk) begin   // Corrected from always @(clk)
    q <= ~a;                  // Corrected to flip the value of a and assign it to q
end
    
endmodule
