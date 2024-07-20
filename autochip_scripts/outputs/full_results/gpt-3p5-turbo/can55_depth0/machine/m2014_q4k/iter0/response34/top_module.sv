module top_module (
   input clk,
   input resetn,
   input in,
   output reg out
);

   reg [3:0] sr; // 4-bit register to store the data

   always @(posedge clk) begin
      if (resetn == 0) begin
         sr <= 4'b0000; // reset the register to all zeros when resetn is low
      end
      else begin
         sr <= {sr[2:0], in}; // shift left by one bit and load input into least significant bit
      end
   end

   assign out = sr[3]; // output is taken from most significant bit

endmodule
