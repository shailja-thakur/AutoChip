module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

   // Perform XOR operation and assign the result to out_assign
   assign out_assign = a ^ b;
   
   // Assign out_assign to out_always_comb using always_comb block
   always_comb begin
      out_always_comb = out_assign;
   end
   
   // Assign out_assign to out_always_ff on rising edge of clk
   always @(posedge clk) begin
      out_always_ff <= out_assign;
   end
   
endmodule
