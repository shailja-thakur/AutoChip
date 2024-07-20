module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  reg [7:0] d_lo;
  reg [7:0] d_hi;
  reg [7:0] q_lo;
  reg [7:0] q_hi;

  always @(posedge clk) begin
    if (!resetn) begin
      d_lo <= 8'b0;
      d_hi <= 8'b0;
      q_lo <= 8'b0;
      q_hi <= 8'b0;
    end else if (byteena[0]) begin
      d_lo <= d[7:0];
      q_lo <= d_lo;
    end else if (byteena[1]) begin
      d_hi <= d[15:8];
      q_hi <= d_hi;
    end
  end

  always @(posedge clk) begin
    if (!resetn) begin
      q <= 16'b0;
    end else begin
      q[7:0] <= q_lo;
      q[15:8] <= q_hi;
    end
  end

endmodule
