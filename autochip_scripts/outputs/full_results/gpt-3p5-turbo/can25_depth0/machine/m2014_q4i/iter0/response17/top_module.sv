module top_module(
    output reg out);

    // Assigning constant value 0 to out
    always @(posedge clk)
        out <= 0;
        
endmodule
