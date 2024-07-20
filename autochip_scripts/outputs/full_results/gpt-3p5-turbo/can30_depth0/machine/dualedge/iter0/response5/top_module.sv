module top_module(
   input clk,
   input d,
   output reg q);

   reg qp, qn;

   always @(posedge clk) begin
      qp <= d;   // Update qp with the value of d on positive clock edge
   end

   always @(negedge clk) begin
      qn <= d;   // Update qn with the value of d on negative clock edge
   end

   always @(clk) begin
      if (clk)
         q <= qp;   // Assign the value of qp to q if clk is positive
      else
         q <= qn;   // Assign the value of qn to q if clk is negative
   end

endmodule
