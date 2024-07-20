module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state, next_state;

  // State definitions
  parameter IDLE = 0;
  parameter S1 = 1;
  parameter S2 = 2;
  parameter ERROR = 3;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      IDLE: begin
        if (in == 1) begin
          next_state = S1;
        end
      end
      S1: begin
        if (in == 0) begin
          next_state = IDLE;
          disc = 0;
          flag = 0;
          err = 0;
        end else if (in == 1) begin
          next_state = S2;
        end
      end
      S2: begin
        if (in == 0) begin
          next_state = IDLE;
          disc = 0;
          flag = 1;
          err = 0;
        end else if (in == 1) begin
          next_state = ERROR;
        end
      end
      ERROR: begin
        if (in == 0) begin
          next_state = IDLE;
          disc = 0;
          flag = 0;
          err = 1;
        end
      end
    endcase
  end
endmodule
