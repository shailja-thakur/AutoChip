module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);
   reg [4:0] next_q;

   always @(posedge clk) begin
      if (reset) begin
         next_q = 5'b1;
      end else begin
         next_q[4] = next_q[3] ^ next_q[0];
         next_q[3] = next_q[2];
         next_q[2] = next_q[1];
         next_q[1] = next_q[0];
         next_q[0] = next_q[4];
      end
   end

   always @(posedge clk) begin
      if (reset) begin
         q <= 5'b1;
      end else begin
         q <= next_q;
      end
   end

endmodule
