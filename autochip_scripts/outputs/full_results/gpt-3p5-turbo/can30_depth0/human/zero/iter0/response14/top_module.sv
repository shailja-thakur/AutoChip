module top_module(
    output reg zero);  // added 'reg' keyword to specify that 'zero' is a register

always @(posedge clk)  // assuming 'clk' is the clock input
    zero <= 0;  // always outputting a LOW

endmodule
