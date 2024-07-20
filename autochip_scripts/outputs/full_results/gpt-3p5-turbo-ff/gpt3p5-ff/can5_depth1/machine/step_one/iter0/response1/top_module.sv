module top_module(
    output reg one);    // Added "reg" keyword to define one as a register
    always @(posedge clk)    // Added clock signal for edge-sensitive behavior
        one <= 1'b1;    // Assigned one to a logic high value
endmodule
