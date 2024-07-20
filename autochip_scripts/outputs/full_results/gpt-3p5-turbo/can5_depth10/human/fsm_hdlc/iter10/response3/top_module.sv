module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

  reg [1:0] state;
  reg [4:0] consecutive_ones;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      consecutive_ones <= 5'b0;
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      case (state)
        2'b00: begin // State_0: Waiting for first consecutive 0 in flag pattern
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b0;
          state <= in ? 2'b01 : 2'b00;
        end
        2'b01: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
          if (in) begin
            consecutive_ones <= consecutive_ones + 1;
            if (consecutive_ones >= 5'b11111) begin
              state <= 2'b10;
            end else if (consecutive_ones == 5'b11110) begin
              state <= 2'b11;
            end
          end else begin
            consecutive_ones <= 5'b0;
            state <= 2'b00;
          end
        end
        2'b10: begin // State_2: Detected 7 or more consecutive 1s (error)
          if (in) begin
            state <= 2'b10;
          end else begin
            state <= 2'b00;
          end
        end
        2'b11: begin // State_3: Detected flag pattern
          if (in) begin
            state <= 2'b00;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case (state)
      2'b01: begin
        disc <= 0;
        flag <= 0;
        err <= 0;
      end
      2'b10: begin
        disc <= 0;
        flag <= 0;
        err <= 1;
      end
      2'b11: begin
        disc <= 0;
        flag <= 1;
        err <= 0;
      end
      default: begin
        disc <= 0;
        flag <= 0;
        err <= 0;
      end
    endcase
  end
endmodule
