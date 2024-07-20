module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );
  
  reg [3:0] delay;
  reg [3:0] timer_count;
  reg [3:0] remaining_time;
  reg [3:0] shift_register;
  reg start_sequence_detected;
  
  // State definitions
  localparam IDLE = 2'b00;
  localparam SHIFT_IN = 2'b01;
  localparam COUNTING = 2'b10;
  
  // Default state assignments
  reg [1:0] state;
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      done <= 0;
      shift_register <= 4'b0;
      delay <= 4'b0;
      timer_count <= 4'b0;
      remaining_time <= 4'b0;
      start_sequence_detected <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 1'b1 && shift_register == 4'b1101) begin
            state <= SHIFT_IN;
          end else begin
            state <= IDLE;
          end
        end
        SHIFT_IN: begin
          state <= COUNTING;
        end
        COUNTING: begin
          if (timer_count < delay) begin
            state <= COUNTING;
          end else begin
            state <= IDLE;
          end
        end
        default: state <= IDLE;
      endcase
    end
  end
  
  
  // Register delay shift
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      delay <= 4'b0;
    end else if (state == SHIFT_IN) begin
      shift_register <= {shift_register[2:0], data};
      if (shift_register == 4'b1101) begin
        delay <= shift_register;
      end
    end
  end
  
  // Timer count
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      timer_count <= 4'b0;
    end else if (state == COUNTING && timer_count < delay) begin
      if (timer_count == 4'b1111) begin
        timer_count <= 4'b0;
      end else begin
        timer_count <= timer_count + 1;
      end
    end
  end
  
  // Remaining time
  always_comb begin
    case (state)
      IDLE: remaining_time = delay;
      SHIFT_IN: remaining_time = delay;
      COUNTING: remaining_time = delay - timer_count;
      default: remaining_time = 4'b0;
    endcase
  end
  
  // Output assignments
  assign count = counting ? remaining_time : 4'b0;
  always_comb begin
    counting = (state == COUNTING);
    done = (state == IDLE && delay != 4'b0);
  end
  
endmodule
