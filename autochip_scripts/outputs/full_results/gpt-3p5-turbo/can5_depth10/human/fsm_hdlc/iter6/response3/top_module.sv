module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

  reg [1:0] state;
  reg [1:0] next_state;
  reg [4:0] consecutive_ones;
  wire temp_disc, temp_flag, temp_err;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;
      next_state <= 2'b00;
      consecutive_ones <= 5'b0;
    end else begin
      state <= next_state;
      case (state)
        2'b00: begin // State_0: Waiting for first consecutive 0 in flag pattern
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b00000;
          next_state <= in ? 2'b01 : 2'b00;
        end
        2'b01: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b00000;
          if (consecutive_ones == 5'b11110) begin
            next_state <= 2'b11;
          end else if (consecutive_ones == 5'b11111) begin
             next_state <= 2'b10;
          end else begin
            next_state <= 2'b01;
          end
        end
        2'b10: begin // State_2: Detected 7 or more consecutive 1s (error)
          consecutive_ones <= in ? 5'b00000 : 5'b00001;
          next_state <= in? 2'b00 : 2'b10;
        end
        2'b11: begin // State_3: Detected flag pattern
          consecutive_ones <= 5'b00001;
          next_state <= in ? 2'b00 : 2'b11;
        end
      endcase
    end
  end

  always @(state) begin
    temp_disc = state == 2'b01; // State_1: Counting consecutive 1s after first 0 in flag pattern
    temp_flag = state == 2'b11; // State_3: Detected flag pattern
    temp_err = state == 2'b10; // State_2: Detected 7 or more consecutive 1s (error)
  end

  always @(posedge clk) begin
    disc <= temp_disc;
    flag <= temp_flag;
    err <= temp_err;
  end
endmodule
