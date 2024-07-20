module top_module(
  input clk,
  input resetn,
  input wire [1:0] byteena,
  input wire [15:0] d,
  output reg [15:0] q
);

  reg [7:0] d_low;
  reg [7:0] q_low;
  reg [7:0] d_high;
  reg [7:0] q_high;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      d_low <= 8'b0;
      d_high <= 8'b0;
    end else begin
      if (byteena[0])
        d_low <= d[7:0];
      if (byteena[1])
        d_high <= d[15:8];
    end
  end

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      q_low <= 8'b0;
      q_high <= 8'b0;
    end else begin
      if (byteena[0])
        q_low <= d_low;
      if (byteena[1])
        q_high <= d_high;
    end
  end

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      q <= 16'b0;
    else
      q <= {q_high, q_low};
  end

endmodule
