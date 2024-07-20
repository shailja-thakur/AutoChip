module top_module(
   input clk,
   input reset,
   output reg [4:0] q);

   reg [4:0] q_next;

   // State Transition always block
   always @(q)
   begin
      q_next = {q[4:1], q[0]};
      q_next[2] = q_next[2] ^ q[0];
   end

   // Logic description always block
   always @(posedge clk)
   begin
      if (reset)
         q <= 5'h1;
      else
         q <= q_next;
   end

endmodule
