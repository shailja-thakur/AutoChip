module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  // Define states
  reg [2:0] state;
  
  // Define state parameters
  parameter IDLE = 0;
  parameter SEARCH = 1;
  parameter SHIFT_ENA = 2;
  parameter WAIT_FOR_DONE = 3;
  parameter NOTIFY_DONE = 4;
  parameter WAIT_FOR_ACK = 5;
  
  // Internal registers
  reg [3:0] shift_count;
  
  // State machine
  always @(posedge clk) begin
    if (reset) begin
      state <= SEARCH;
      shift_count <= 4'b0;
      shift_ena <= 1'b0;
      counting <= 1'b0;
      done <= 1'b0;
    end else begin
      case (state)
        IDLE:
          if (data == 4'b1101) begin
            state <= SHIFT_ENA;
            shift_count <= 4'b0;
            shift_ena <= 1'b1;
          end else begin
            state <= SEARCH;
            shift_count <= 4'b0;
            shift_ena <= 1'b0;
          end
        SEARCH:
          if (data == 4'b1101) begin
            state <= SHIFT_ENA;
            shift_count <= 4'b0;
            shift_ena <= 1'b1;
          end else begin
            state <= SEARCH;
            shift_count <= 4'b0;
            shift_ena <= 1'b0;
          end
        SHIFT_ENA:
          if (shift_count >= 4'b1111) begin
            state <= WAIT_FOR_DONE;
            counting <= 1'b1;
          end else begin
            state <= SHIFT_ENA;
            shift_count <= shift_count + 1;
          end
        WAIT_FOR_DONE:
          if (done_counting) begin
            state <= NOTIFY_DONE;
            counting <= 1'b0;
            done <= 1'b1;
          end else begin
            state <= WAIT_FOR_DONE;
          end
        NOTIFY_DONE:
          if (ack) begin
            state <= WAIT_FOR_ACK;
            done <= 1'b0;
          end else begin
            state <= NOTIFY_DONE;
          end
        WAIT_FOR_ACK:
          if (ack) begin
            state <= SEARCH;
          end else begin
            state <= WAIT_FOR_ACK;
          end
      endcase
    end
  end
endmodule
