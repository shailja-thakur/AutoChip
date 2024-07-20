module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );
  
  reg [3:0] delay;
  reg [3:0] counter;
  reg [3:0] remaining;
  reg [3:0] next_state;
  reg [2:0] state;
  reg start_sequence;
  wire [3:0] next_counter;
  wire [3:0] next_remaining;
  
  parameter IDLE = 0;
  parameter CHECK_SEQUENCE = 1;
  parameter READ_DELAY = 2;
  parameter COUNT = 3;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
      remaining <= 0;
      next_state <= IDLE;
      start_sequence <= 0;
    end
    else begin
      state <= next_state;
      counting <= (state == COUNT);
      done <= (state == IDLE) & ack;
      delay <= (state == READ_DELAY) ? data : delay;
      counter <= (state == COUNT) ? next_counter : counter;
      remaining <= (state == COUNT) ? next_remaining : remaining;
      start_sequence <= (state == IDLE) ? (data == 4'b1101) : start_sequence;
    end
  end
  
  always @(state or delay or counter or start_sequence) begin
    case(state)
      IDLE: begin
        next_state <= CHECK_SEQUENCE;
      end
      CHECK_SEQUENCE: begin
        if (start_sequence) begin
          next_state <= READ_DELAY;
        end
        else begin
          next_state <= CHECK_SEQUENCE;
        end
      end
      READ_DELAY: begin
        next_state <= COUNT;
      end
      COUNT: begin
        next_state <= (counter > 0) ? COUNT : IDLE;
      end
    endcase
  end
  
  assign count = remaining;

  assign next_counter = (counter > 0) ? (counter - 1) : delay;
  assign next_remaining = (counter == 0) ? (remaining - 1) : delay;
  
endmodule
