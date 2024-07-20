module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

   // Declare variables
   reg [511:0] q_next;
   reg [511:0] q_temp;

   // Assign initial values
   initial begin
      q_next = 512'b0;
      q_temp = 512'b0;
   end

   // Load input data
   always @(posedge clk) begin
      if (load) begin
         q_next = data;
      end
   end

   // Cellular Automaton Rule 110
   always @(posedge clk) begin
      for (int i = 0; i < 512; i = i + 1) begin
         if (i == 0) begin
            q_temp[i] <= (q_next[i] & q_next[i+1]);
         end else if (i == 511) begin
            q_temp[i] <= (q_next[i-1] & q_next[i]);
         end else begin
            q_temp[i] <= (q_next[i-1] ^ (q_next[i] | q_next[i+1]));
         end
      end
   end

   // Update current state
   always @(posedge clk) begin
      q <= q_temp;
   end

endmodule
