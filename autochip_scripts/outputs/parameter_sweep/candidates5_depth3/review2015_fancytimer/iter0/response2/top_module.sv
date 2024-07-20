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
  reg start_sequence_detected;
  reg [3:0] state;

  localparam idle_state = 4'b0000;
  localparam start_sequence_state = 4'b0001;
  localparam shift_in_state = 4'b0010;
  localparam count_state = 4'b0011;
  localparam done_state = 4'b0100;

  always @(posedge clk) begin
    if (reset) begin
      counting <= 0;
      done <= 0;
      start_sequence_detected <= 0;
      state <= idle_state;
      remaining_time <= 0;
    end else begin
      case(state)
        idle_state: begin
          if (data == 4'b1101) begin
            delay <= data;
            state <= start_sequence_state;
          end
        end

        start_sequence_state: begin
          start_sequence_detected <= 1;
          state <= shift_in_state;
        end

        shift_in_state: begin
          delay <= {delay[2:0], data[3]};
          state <= count_state;
        end

        count_state: begin
          counting <= 1;
          count <= remaining_time;
          remaining_time <= remaining_time - 1;
          if (remaining_time == 0) begin
            state <= done_state;
          end
        end

        done_state: begin
          if (ack) begin
            counting <= 0;
            done <= 1;
            state <= idle_state;
          end
        end
      endcase
    end
  end
endmodule
