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
  reg start_detected;
  reg [11:0] timer;
  reg [11:0] remaining_time;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      delay <= 4'b0000;
      counting <= 1'b0;
      done <= 1'b0;
      timer <= 12'b0;
      remaining_time <= 12'b0;
    end else begin
      case (state)
        3'b000: begin // IDLE state
          if (data == 1'b1 && $past(data) == 1'b1 && $past($past(data)) == 1'b0 && $past($past($past(data))) == 1'b1) begin
            state <= 3'b001; // DETECT state
            start_detected <= 1'b1;
            delay <= data;
          end
        end
        3'b001: begin // DETECT state
          if (!start_detected && data == 1'b1) begin
            state <= 3'b011; // RESET state
          end else if (remaining_time == 12'b0) begin
            state <= 3'b010; // COUNT state
            counting <= 1'b1;
          end
        end
        3'b010: begin // COUNT state
          if (timer == (delay + 1) * 1000 - 1) begin
            state <= 3'b011; // RESET state
            counting <= 1'b0;
          end
        end
        3'b011: begin // RESET state
          if (ack == 1'b1) begin
            state <= 3'b000; // IDLE state
            done <= 1'b1;
            start_detected <= 1'b0;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      count <= 4'b0000;
    end else begin
      case(state)
        3'b010: begin // COUNT state
          if (timer >= 1000) begin
            count <= delay;
          end else begin
            count <= count - 1;
          end
        end
        default: begin
          count <= 4'b0000;
        end
      endcase
      timer <= timer + 1;
      remaining_time <= (delay - count) * 1000 - (timer % 1000);
    end
  end

endmodule
