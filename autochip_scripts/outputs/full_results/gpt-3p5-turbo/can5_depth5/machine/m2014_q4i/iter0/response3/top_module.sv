module top_module(
    output reg out);
    
    // Assign output port to a constant value of 0
    always @(posedge clk)
        out <= 0;
    
endmodule
