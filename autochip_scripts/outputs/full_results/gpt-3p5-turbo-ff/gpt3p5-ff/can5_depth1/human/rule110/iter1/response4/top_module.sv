module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] temp;
  wire [511:0] q_delayed;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      temp[511] <= (q[510] & q_delayed[511]) | (q_delayed[511] & q[510]) |
                   (q[510] & ~q[509]) | (~q[510] & ~q[509]);
      temp[510:0] <= q_delayed[511:1];
      q <= temp;
    end
  end
  
  always @(posedge clk) begin
    q_delayed <= q;
  end

endmodule
