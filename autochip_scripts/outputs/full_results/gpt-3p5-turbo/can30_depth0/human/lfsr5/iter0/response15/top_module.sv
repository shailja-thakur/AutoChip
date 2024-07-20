module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      next_state <= 5'b1;
    end else begin
      next_state <= {next_state[2] ^ next_state[0], next_state[4:1]};
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      q <= 5'b1;
    end else begin
      q <= next_state;
    end
  end

endmodule
