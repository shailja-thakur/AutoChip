module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err);

  parameter S0 = 3'b000;
  parameter S1 = 3'b001;
  parameter S2 = 3'b010;
  parameter S3 = 3'b011;

  reg [2:0] state;
  reg next_state, next_disc, next_flag, next_err;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= S0;
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      state <= next_state;
      disc <= next_disc;
      flag <= next_flag;
      err <= next_err;
    end
  end

  always @(state or in) begin
    next_state = state;
    next_disc = 0;
    next_flag = 0;
    next_err = 0;

    case (state)
      S0: begin
        if (in == 1) begin
          next_state = S1;
        end
      end

      S1: begin
        if (in == 1) begin
          next_state = S2;
        end else begin
          next_disc = 1;
        end
      end

      S2: begin
        if (in == 1) begin
          next_state = S3;
        end else begin
          next_disc = 0;
          next_flag = 1;
        end
      end

      S3: begin
        if (in == 1) begin
          next_err = 1;
        end else begin
          next_disc = 1;
        end
      end
    endcase
  end

endmodule
