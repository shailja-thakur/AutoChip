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
    end else begin
      case (state)
        2'b00: begin // State_0: Waiting for first consecutive 0 in flag pattern
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b00000;
          state <= in ? 2'b01 : 2'b00;
        end
        2'b01: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b00000;
          state <= (consecutive_ones == 5'b11110) ? 2'b11 : 
                        (consecutive_ones == 5'b11111) ? 2'b10 : 2'b01;
        end
        2'b10: begin // State_2: Detected 7 or more consecutive 1s (error)
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b00000;
          state <= in ? 2'b00 : 2'b10;
        end
        2'b11: begin // State_3: Detected flag pattern
          consecutive_ones <= in ? 5'b00001 : 5'b00000;
          state <= 2'b00;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    disc <= 0;
    flag <= 0;
    err <= 0;
    case (state)
      2'b01: disc <= (consecutive_ones == 5'b11110);
      2'b10: err <= 1;
      2'b11: flag <= 1;
    endcase
  end
endmodule
