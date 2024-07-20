module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  // State declaration
  reg [3:0] state;

  // Sequential logic
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= 4'b0000;
    else
      case (state)
        4'b0000: if (data) state <= 4'b0001;
                 else state <= 4'b0000;
        4'b0001: if (data) state <= 4'b0011;
                 else state <= 4'b0000;
        4'b0011: if (data) state <= 4'b0010;
                 else state <= 4'b0000;
        4'b0010: if (data) state <= 4'b1011;
                 else state <= 4'b0000;
        4'b1011: start_shifting <= 1;
                 state <= 4'b0000;
        default: state <= 4'b0000;
      endcase
  end

endmodule
