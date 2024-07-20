module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

  reg [2:0] state;
  reg [2:0] next_state;
  reg [5:0] consecutive_ones;
  reg temp_disc, temp_flag, temp_err;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      next_state <= 3'b000;
      consecutive_ones <= 6'b0;
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      state <= next_state;
      case (state)
        3'b000: begin // State_0: Waiting for first consecutive 0 in flag pattern
          if (in) begin
            consecutive_ones <= 6'b000001;
            next_state <= 3'b001;
          end else begin
            consecutive_ones <= 6'b000000;
            next_state <= 3'b000;
          end
        end
        3'b001: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
          if (in) begin
            consecutive_ones <= consecutive_ones + 1;
            if (consecutive_ones == 6'b111110) begin
              next_state <= 3'b011;
            end else if (consecutive_ones == 6'b111111) begin
              next_state <= 3'b010;
            end else begin
              next_state <= 3'b001;
            end
          end else begin
            consecutive_ones <= 6'b000000;
            next_state <= 3'b000;
          end
        end
        3'b010: begin // State_2: Detected 7 or more consecutive 1s (error)
          if (!in) begin
            consecutive_ones <= 6'b000000;
            next_state <= 3'b100;
          end
        end
        3'b011: begin // State_3: Detected flag pattern
          consecutive_ones <= 6'b000000;
          next_state <= 3'b100;
        end
        3'b100: begin // State_4: Waiting for first consecutive 0 after flag pattern
          if (in) begin
            consecutive_ones <= 6'b000001;
            next_state <= 3'b001;
          end else begin
            consecutive_ones <= 6'b000000;
            next_state <= 3'b100;
          end
        end
      endcase
    end
  end

  always @(state, in) begin
    temp_disc = 0;
    temp_flag = 0;
    temp_err = 0;
    case (state)
      3'b010: temp_disc = 1; // State_2: Detected 7 or more consecutive 1s (error)
      3'b011: temp_flag = 1; // State_3: Detected flag pattern
      3'b100: temp_err = 1; // State_4: Waiting for first consecutive 0 after flag pattern
    endcase

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
