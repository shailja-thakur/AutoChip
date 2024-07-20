module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

  reg [2:0] state;
  reg [2:0] next_state;
  reg [4:0] consecutive_ones;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b0;
      next_state <= 3'b0;
      consecutive_ones <= 5'b0;
    end else begin
      state <= next_state;
      case (state)
        3'b000: begin // State_0: Waiting for first consecutive 0 in flag pattern
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b00000;
          next_state <= in ? 3'b001 : 3'b000;
        end
        3'b001: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
          consecutive_ones <= in ? consecutive_ones + 1 : 5'b00000;
          next_state <= (consecutive_ones == 5'b11110) ? 3'b011 : 
                        (consecutive_ones >= 5'b11111) ? 3'b010 : 3'b001;
        end
        3'b010: begin // State_2: Detected 7 or more consecutive 1s (error)
          consecutive_ones <= in ? 5'b00001 : 5'b00000;
          next_state <= in ? 3'b000 : 3'b010;
        end
        3'b011: begin // State_3: Detected flag pattern
          consecutive_ones <= in ? 5'b00001 : 5'b00000;
          next_state <= 3'b000;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    disc <= 0;
    flag <= 0;
    err <= 0;
    case (state)
      3'b001: disc <= (consecutive_ones >= 5'b11111);
      3'b010: err <= 1;
      3'b011: flag <= 1;
    endcase
  end
endmodule
