module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  reg [7:0] lower_byte;
  reg [7:0] upper_byte;
  reg [7:0] q_lower_byte;
  reg [7:0] q_upper_byte;

  always @(posedge clk) begin
    if (resetn == 0) begin
      lower_byte <= 8'b0;
      upper_byte <= 8'b0;
    end else begin
      if (byteena[0] == 1) begin
        lower_byte <= d[7:0];
      end
      if (byteena[1] == 1) begin
        upper_byte <= d[15:8];
      end
    end
  end

  always @(posedge clk) begin
    if (resetn == 0) begin
      q_lower_byte <= 8'b0;
      q_upper_byte <= 8'b0;
    end else begin
      q_lower_byte <= lower_byte;
      q_upper_byte <= upper_byte;
    end
  end

  always @(posedge clk) begin
    if (resetn == 0) begin
      q <= 16'b0;
    end else begin
      q <= {q_upper_byte, q_lower_byte};
    end
  end

endmodule
