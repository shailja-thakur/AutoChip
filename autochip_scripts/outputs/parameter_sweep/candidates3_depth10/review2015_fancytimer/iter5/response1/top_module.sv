module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] remaining_time;
  reg [3:0] state;
  reg [3:0] next_state;
  reg [3:0] next_remaining_time;
  
  reg [15:0] cycles;
  wire reset_delay_reached;

  parameter IDLE = 4'b0000;
  parameter DETECT_PATTERN = 4'b0001;
  parameter SHIFT_IN_DELAY = 4'b0010;
  parameter COUNTING = 4'b0011;
  parameter WAIT_FOR_ACK = 4'b0100;

  always @(posedge clk or posedge reset)
  begin
    if (reset)
    begin
      state <= IDLE;
      delay <= 0;
      count <= 0;
      counting <= 0;
      done <= 0;
      remaining_time <= 0;
      cycles <= 0;
      next_remaining_time <= 0;
    end
    else
    begin
      state <= next_state;
      delay <= (state == SHIFT_IN_DELAY) ? data : delay;
      count <= (counting && (state == COUNTING)) ? remaining_time : count;
      remaining_time <= (state == COUNTING && remaining_time > 0) ? remaining_time - 1 : delay;
    end
  end
  
  always @(posedge clk)
  begin
    if (reset)
    begin
      counting <= 0;
      cycles <= 0;
      next_remaining_time <= 0;
    end
    else
    begin
      counting <= (state == COUNTING && remaining_time > 0) ? 1 : 0;
      cycles <= cycles + 1;
      reset_delay_reached <= (cycles == (delay + 1) * 1000) ? 1 : 0;
      
      if (reset_delay_reached)
      begin
        next_remaining_time <= (next_state == COUNTING) ? next_remaining_time - 1 : delay;
      end
      else
      begin
        next_remaining_time <= remaining_time;
      end
    end
  end

  always @(posedge clk or posedge reset)
  begin
    if (reset)
    begin
      next_state <= IDLE;
    end
    else
    begin
      case (state)
        IDLE:
          if (data == 4'b1101)
          begin
            next_state <= DETECT_PATTERN;
            next_remaining_time <= 0;
            counting <= 0;
          end
          else
          begin
            next_state <= IDLE;
          end
        DETECT_PATTERN:
          next_state <= SHIFT_IN_DELAY;
        SHIFT_IN_DELAY:
          if (next_remaining_time == 4'b1111)
          begin
            next_state <= COUNTING;
            counting <= 1;
            cycles <= 0;
          end
          else
          begin
            next_state <= SHIFT_IN_DELAY;
          end
        COUNTING:
          if (remaining_time == 0)
          begin
            next_state <= WAIT_FOR_ACK;
            counting <= 0;
          end
          else
          begin
            if (cycles == (delay + 1) * 1000)
            begin
              next_state <= COUNTING;
              counting <= 1;
              cycles <= 0;
            end
            else
            begin
              next_state <= COUNTING;
              counting <= 1;
            end
          end
        WAIT_FOR_ACK:
          if (ack)
          begin
            next_state <= IDLE;
          end
          else
          begin
            next_state <= WAIT_FOR_ACK;
          end
      endcase
    end
  end

  always @(posedge reset)
  begin
    if (reset)
    begin
      done <= 0;
    end
    else
    begin
      if (state == WAIT_FOR_ACK)
      begin
        done <= 1;
      end
      else
      begin
        done <= 0;
      end
    end
  end

endmodule
