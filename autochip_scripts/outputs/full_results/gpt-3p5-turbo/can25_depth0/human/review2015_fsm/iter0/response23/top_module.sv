module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  parameter START = 2'b00;
  parameter SHIFT_IN = 2'b01;
  parameter WAIT_COUNT = 2'b10;
  parameter DONE = 2'b11;

  reg [1:0] state;
  reg [3:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= START;
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
      count <= 0;
    end else begin
      case (state)
        START: begin
          if (data == 4'b1101) begin
            state <= SHIFT_IN;
            shift_ena <= 1;
            count <= 0;
          end
        end

        SHIFT_IN: begin
          if (count == 4) begin
            state <= WAIT_COUNT;
            shift_ena <= 0;
            counting <= 1;
          end else begin
            count <= count + 1;
          end
        end

        WAIT_COUNT: begin
          if (done_counting) begin
            state <= DONE;
            done <= 1;
          end
        end

        DONE: begin
          if (ack) begin
            state <= START;
            done <= 0;
          end
        end
      endcase
    end
  end

endmodule
