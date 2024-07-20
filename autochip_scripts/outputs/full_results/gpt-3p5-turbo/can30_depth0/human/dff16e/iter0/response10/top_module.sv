module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  reg [7:0] q_l;
  reg [7:0] q_u;

  always @(posedge clk or negedge resetn) begin
    if (~resetn)
      begin
        q_l <= 8'd0;
        q_u <= 8'd0;
      end
    else begin
      if (byteena[0])
        q_l <= d[7:0];
      
      if (byteena[1])
        q_u <= d[15:8];
    end
  end

  always @(posedge clk) begin
    if (~resetn)
      q <= 16'd0;
    else
      q <= {q_u, q_l};
  end
endmodule
