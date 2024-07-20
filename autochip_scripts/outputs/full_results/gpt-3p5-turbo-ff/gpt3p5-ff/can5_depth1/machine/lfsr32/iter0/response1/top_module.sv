module top_module(
   input clk,
   input reset,
   output reg [31:0] q
);

reg [31:0] q_next;
reg [0:31] q_rev;

always @(posedge clk) begin
   if (reset) begin
      q <= 32'h1;
   end else begin
      q <= q_next;
   end
end

always @(posedge clk) begin
   q_next[31:1] <= q_rev[30:0];
   q_next[0] <= q_rev[21] ^ q_rev[1] ^ q_rev[0];
end

always @(posedge clk) begin
   q_rev[31:1] <= q[30:0];
   q_rev[0] <= q[30] ^ q[0];
end

endmodule
