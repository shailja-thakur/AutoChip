module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_temp;

  always @(posedge clk) begin
    if (reset)
      q_temp <= 32'b1;
    else begin
      q_temp <= {q_temp[31]^q_temp[21]^q_temp[1]^q_temp[0], q_temp[31:1]};
    end
  end

  always @(posedge clk) begin
    q <= q_temp;
  end

endmodule
