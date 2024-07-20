module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] curr_state;
  always @(posedge clk) begin
    if (reset)
      curr_state <= 32'b1;
    else begin
      curr_state <= {curr_state[31]^curr_state[21]^curr_state[1]^curr_state[0], curr_state[31:1]};
    end
  end
  
  always @(posedge clk) begin
    if (reset)
      q <= 32'b1;
    else
      q <= curr_state;
  end

endmodule
