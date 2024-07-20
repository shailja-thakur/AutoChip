module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= 4'b0000;
    else
      state <= next_state;
  end

  always @(*)
  begin
    next_state = state;
    case (state)
      4'b0000: if (data) next_state = 4'b0001;
      4'b0001: if (data) next_state = 4'b0011; else next_state = 4'b0000;
      4'b0011: if (data) next_state = 4'b0100; else next_state = 4'b0000;
      4'b0100: if (data) begin next_state = 4'b0001; start_shifting = 1; end else next_state = 4'b0000;
      default: next_state = 4'b0000;
    endcase
  end

endmodule
