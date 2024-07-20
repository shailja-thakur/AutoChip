module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );
  
  reg [3:0] delay;
  reg [2:0] state;
  reg [3:0] counter;
  reg [3:0] remaining_time;
  wire start_sequence_matched;
  
  // state machine states
  localparam IDLE = 3'b000;
  localparam DETECTED = 3'b001;
  localparam SHIFT_IN = 3'b010;
  localparam COUNTING = 3'b011;
  localparam DONE = 3'b100;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
      remaining_time <= 0;
    end else begin
      case(state)
        IDLE:
          if (start_sequence_matched == 1) begin
            state <= DETECTED;
            counter <= 0;
            remaining_time <= delay;
          end else begin
            state <= IDLE;
          end
        DETECTED:
          if (counter == 3) begin
            state <= SHIFT_IN;
            delay <= data;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        SHIFT_IN:
          if (counter == 3) begin
            state <= COUNTING;
            counting <= 1;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        COUNTING:
          if (counter == ((delay + 1) * 1000 - 1)) begin
            state <= DONE;
            counting <= 0;
            done <= 1;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        DONE:
          if (ack == 1) begin
            state <= IDLE;
            done <= 0;
          end else begin
            state <= DONE;
          end
      endcase
    end
  end

  assign count = counting ? remaining_time : 4'bxxxx;

  // Detect start sequence: 1101
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      start_sequence_matched <= 0;
    end else begin
      if (state == IDLE) begin
        if (data == 1) begin
          start_sequence_matched <= 0;
        end else if (data == 0 && $past(data) == 1 && $past($past(data)) == 1 && $past($past($past(data))) == 0) begin
          start_sequence_matched <= 1;
        end else begin
          start_sequence_matched <= 0;
        end
      end else begin
        start_sequence_matched <= 0;
      end
    end
  end

endmodule
