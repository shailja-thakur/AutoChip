module top_module(
   input clk,
   input d,
   output reg q
);

   reg q;

   initial begin
      q = 1'bX; // Set initial value of q to unknown
   end

   always @(posedge clk) begin
      q <= d; // Assign q to the value of d on the rising edge of clk
   end

endmodule
