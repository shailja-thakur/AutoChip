module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  // FSM states
  parameter S_IDLE = 2'b00;
  parameter S_1 = 2'b01;
  parameter S_11 = 2'b10;
  parameter S_110 = 2'b11;

  reg [1:0] state;
  reg start_shift_reg;

  always @(posedge clk) begin
    if (reset) begin
      state <= S_IDLE;
      start_shifting <= 0;
      start_shift_reg <= 0;
    end
    else begin
      case(state)
        S_IDLE: begin
          if (data) begin
            state <= S_1;
            start_shift_reg <= 0;
          end
        end
        S_1: begin
          if (data) begin
            state <= S_11;
            start_shift_reg <= 0;
          end
          else begin
            state <= S_IDLE;
            start_shift_reg <= 0;
          end
        end
        S_11: begin
          if (data) begin
            state <= S_110;
            start_shift_reg <= 0;
          end
          else begin
            state <= S_IDLE;
            start_shift_reg <= 0;
          end
        end
        S_110: begin
          if (data) begin
            state <= S_110;
            start_shift_reg <= 1;
          end
          else begin
            state <= S_IDLE;
            start_shift_reg <= 0;
          end
        end
      endcase
    end
  end

  assign start_shifting = start_shift_reg;

endmodule
