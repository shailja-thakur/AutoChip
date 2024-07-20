module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  // State declaration
  reg [1:0] state;
  reg start_shift_temp;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      start_shift_temp <= 1'b0;
    end
    else begin
      case (state)
        2'b00:
          if (data) state <= 2'b01;
        2'b01:
          if (data) state <= 2'b10;
          else state <= 2'b00;
        2'b10:
          if (data) state <= 2'b11;
          else state <= 2'b00;
        2'b11:
          if (data) begin
            state <= 2'b01;
            start_shift_temp <= 1'b1;
          end
          else state <= 2'b00;
      endcase
    end
  end

  assign start_shifting = start_shift_temp;

endmodule
