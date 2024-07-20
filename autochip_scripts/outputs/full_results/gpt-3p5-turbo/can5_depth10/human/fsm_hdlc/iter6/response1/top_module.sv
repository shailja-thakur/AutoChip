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
  reg temp_disc, temp_flag, temp_err;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      next_state <= 2'b00;
      consecutive_ones <= 5'b0;
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      state <= next_state;
      case (state)
        2'b00: begin // State_0: Waiting for first consecutive 0 in flag pattern
          if (in) begin
            consecutive_ones <= 5'b00001;
            next_state <= 2'b01;
          end else begin
            consecutive_ones <= 5'b00000;
            next_state <= 2'b00;
          end
        end
        2'b01: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
          if (in) begin
            consecutive_ones <= consecutive_ones + 1;
            if (consecutive_ones == 5'b11110) begin
              next_state <= 2'b11;
            end else if (consecutive_ones == 5'b11111) begin
              next_state <= 2'b10;
            end else begin
              next_state <= 2'b01;
            end
          end else begin
            consecutive_ones <= 5'b00000;
            next_state <= 2'b00;
          end
        end
        2'b10: begin // State_2: Detected 7 or more consecutive 1s (error)
          if (!in) begin
            consecutive_ones <= 5'b00000;
            next_state <= 2'b10;
          end
          else
          begin
            next_state <= 2'b00;
          end
        end
        2'b11: begin // State_3: Detected flag pattern
          consecutive_ones <= 5'b00000;
          next_state <= 2'b00;
        end
      endcase
    end
  end

  always @(state) begin
    temp_disc = 0;
    temp_flag = 0;
    temp_err = 0;
    case (state)
      2'b01: temp_disc = 1; // State_1: Discarding a bit
      2'b10: temp_err = 1; // State_2: Detected 7 or more consecutive 1s (error)
      2'b11: temp_flag = 1; // State_3: Detected flag pattern
    endcase
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      disc <= temp_disc;
      flag <= temp_flag;
      err <= temp_err;
    end
  end
endmodule
