module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 4'b0000;
      start_shifting <= 0;
    end
    else begin
      state <= next_state;
      start_shifting <= (state == 4'b1101);
    end
  end

  always @(state, data) begin
    case (state)
      4'b0000: next_state = (data) ? 4'b0001 : 4'b0000;
      4'b0001: next_state = (data) ? 4'b0011 : 4'b0000;
      4'b0011: next_state = (data) ? 4'b1011 : 4'b0001;
      4'b1011: next_state = (data) ? 4'b1101 : 4'b0001;
      default: next_state = 4'b0000;
    endcase
  end

endmodule
