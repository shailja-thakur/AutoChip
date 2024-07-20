module top_module (
   input clk,
   input a,
   output reg [2:0] q
);
   // Create a register to hold the current value of q
   reg [2:0] q_reg;

   always @(posedge clk) begin
      // Update the value of q_reg on every positive clock edge
      q_reg <= q;

      // Check the input value of 'a' and current value of 'q_reg'
      if (a) begin
         q_reg <= 3'b100; // Set q_reg to 4
      end else begin
         if (q_reg == 3'b110) begin // q_reg is 6
            q_reg <= 3'b000; // Set q_reg to 0
         end else begin
            q_reg <= q_reg + 1; // Increment q_reg by 1
         end
      end
   end

   // Assign the value of q_reg to the output q
   assign q = q_reg;

endmodule
