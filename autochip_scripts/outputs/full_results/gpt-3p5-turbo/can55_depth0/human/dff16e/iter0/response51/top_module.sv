module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  reg [7:0] lower_d;
  reg [7:0] upper_d;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      q <= 16'd0;
    else begin
      if (byteena[0])
        lower_d <= d[7:0];
      if (byteena[1])
        upper_d <= d[15:8];
      q <= {upper_d, lower_d};
    end
  end

endmodule
