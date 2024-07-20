module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0000;
    else
      state <= next_state;
  end

  always @(state or data) begin
    case (state)
      4'b0000: begin
        if (data == 1'b1)
          next_state = 4'b0001;
        else
          next_state = 4'b0000;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
      end

      4'b0001: begin
        if (data == 1'b1)
          next_state = 4'b0010;
        else
          next_state = 4'b0000;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
      end

      4'b0010: begin
        if (data == 1'b0)
          next_state = 4'b0011;
        else
          next_state = 4'b0000;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
      end

      4'b0011: begin
        if (data == 1'b1)
          next_state = 4'b0100;
        else
          next_state = 4'b0000;
        shift_ena = 1'b1;
        counting = 1'b1;
        done = 1'b0;
      end

      4'b0100: begin
        if (data == 1'b1)
          next_state = 4'b0101;
        else
          next_state = 4'b0000;
        shift_ena = 1'b1;
        counting = 1'b1;
        done = 1'b0;
      end

      4'b0101: begin
        if (data == 1'b1)
          next_state = 4'b0110;
        else
          next_state = 4'b0000;
        shift_ena = 1'b1;
        counting = 1'b1;
        done = 1'b0;
      end

      4'b0110: begin
        if (data == 1'b0)
          next_state = 4'b0111;
        else
          next_state = 4'b0000;
        shift_ena = 1'b1;
        counting = 1'b1;
        done = 1'b0;
      end

      4'b0111: begin
        if (data == 1'b1 && done_counting)
          next_state = 4'b1000;
        else
          next_state = 4'b0000;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
      end

      4'b1000: begin
        if (ack)
          next_state = 4'b0000;
        else
          next_state = 4'b1000;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b1;
      end
    endcase
  end
endmodule
