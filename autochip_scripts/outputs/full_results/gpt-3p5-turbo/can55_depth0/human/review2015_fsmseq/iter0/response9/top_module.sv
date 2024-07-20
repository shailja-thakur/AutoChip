module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg start_shifting_next;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0000;
    else
      state <= {state[2:0], data};

    case (state)
      4'b0000: start_shifting_next <= 0;
      4'b0001: start_shifting_next <= 0;
      4'b0010: start_shifting_next <= 0;
      4'b0011: start_shifting_next <= 1;
      4'b0100: start_shifting_next <= 0;
      4'b0101: start_shifting_next <= 0;
      4'b0110: start_shifting_next <= 0;
      4'b0111: start_shifting_next <= 0;
      4'b1000: start_shifting_next <= 0;
      4'b1001: start_shifting_next <= 0;
      4'b1010: start_shifting_next <= 0;
      4'b1011: start_shifting_next <= 0;
      4'b1100: start_shifting_next <= 0;
      4'b1101: start_shifting_next <= 1;
      4'b1110: start_shifting_next <= 0;
      4'b1111: start_shifting_next <= 0;
      default: start_shifting_next <= 0;
    endcase
  end

  always @(posedge clk) begin
    if (reset)
      start_shifting <= 0;
    else
      start_shifting <= start_shifting_next;
  end

endmodule
