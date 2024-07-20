module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] temp_q;

  always @(posedge clk) begin
    if (reset) begin
      temp_q <= 32'h1;
    end else begin
      temp_q <= {temp_q[30:0], temp_q[21] ^ temp_q[19] ^ temp_q[1] ^ temp_q[0]};
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= temp_q;
    end
  end

endmodule
