module top_module(
  input clk,
  input reset,
  output shift_ena
);

  reg [1:0] state;

  parameter IDLE = 2'b00;
  parameter DETECT_PATTERN = 2'b01;
  parameter ENABLE_SHIFT = 2'b10;

  reg [3:0] counter;

  always @(posedge clk) begin
    if (reset)
      state <= IDLE;
    else begin
      case (state)
        IDLE:
          if (pattern_detected)
            state <= DETECT_PATTERN;
          else
            state <= IDLE;
        DETECT_PATTERN:
          state <= ENABLE_SHIFT;
        ENABLE_SHIFT:
          if (counter == 4)
            state <= IDLE;
          else
            state <= ENABLE_SHIFT;
        default:
          state <= IDLE;
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset)
      counter <= 0;
    else begin
      if (state == ENABLE_SHIFT) begin
        if (counter == 4) begin
          shift_ena <= 0;
          counter <= 0;
        end else begin
          shift_ena <= 1;
          counter <= counter + 1;
        end
      end else
        counter <= 0;
    end
  end

endmodule
