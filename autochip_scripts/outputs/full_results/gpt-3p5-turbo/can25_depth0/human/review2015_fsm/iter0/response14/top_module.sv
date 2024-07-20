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

  parameter START = 4'b0000;
  parameter SHIFT_ENA = 4'b0001;
  parameter COUNTING = 4'b0010;
  parameter DONE = 4'b0011;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= START;
    end else begin
      state <= next_state;
    end
  end

  always @(state or data or done_counting or ack) begin
    case (state)
      START: begin
        if (data == 4'b1101) begin
          shift_ena <= 1;
          counting <= 0;
          done <= 0;
          next_state <= SHIFT_ENA;
        end else begin
          shift_ena <= 0;
          counting <= 0;
          done <= 0;
          next_state <= START;
        end
      end

      SHIFT_ENA: begin
        shift_ena <= 1;
        counting <= 0;
        done <= 0;
        next_state <= COUNTING;
      end

      COUNTING: begin
        shift_ena <= 0;
        counting <= 1;
        done <= 0;
        if (done_counting) begin
          next_state <= DONE;
        end else begin
          next_state <= COUNTING;
        end
      end

      DONE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 1;
        if (ack) begin
          next_state <= START;
        end else begin
          next_state <= DONE;
        end
      end
      
      default: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        next_state <= START;
      end
    endcase
  end

endmodule
