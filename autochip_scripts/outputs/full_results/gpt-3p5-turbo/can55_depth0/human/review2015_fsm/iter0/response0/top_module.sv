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

  parameter IDLE = 4'b0000;
  parameter SEARCH = 4'b0001;
  parameter SHIFT = 4'b0010;
  parameter COUNTING = 4'b0011;
  parameter TIMEOUT = 4'b0100;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  always @(state or data or done_counting) begin
    case(state)
      IDLE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        if (data == 4'b1101) begin
          next_state <= SEARCH;
        end else begin
          next_state <= IDLE;
        end
      end
      SEARCH: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        if (data == 4'b1101) begin
          next_state <= SHIFT;
        end else begin
          next_state <= SEARCH;
        end
      end
      SHIFT: begin
        shift_ena <= 1;
        counting <= 0;
        done <= 0;
        next_state <= COUNTING;
      end
      COUNTING: begin
        shift_ena <= 0;
        counting <= 1;
        if (done_counting) begin
          next_state <= TIMEOUT;
        end else begin
          next_state <= COUNTING;
        end
      end
      TIMEOUT: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 1;
        if (ack) begin
          next_state <= IDLE;
        end else begin
          next_state <= TIMEOUT;
        end
      end
    endcase
  end
endmodule
