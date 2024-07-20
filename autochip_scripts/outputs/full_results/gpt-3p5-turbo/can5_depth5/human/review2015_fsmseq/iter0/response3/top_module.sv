module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting
);
  reg [3:0] state;
  reg start_shifting_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
    end else begin
      case (state)
        0: begin
          if (data) begin
            state <= 1;
          end
        end
        1: begin
          if (data) begin
            state <= 2;
          end else begin
            state <= 0;
          end
        end
        2: begin
          if (data) begin
            state <= 3;
          end else begin
            state <= 0;
          end
        end
        3: begin
          if (~data) begin
            state <= 0;
          end else begin
            start_shifting_reg <= 1;
            state <= 4;
          end
        end
        4: begin
          start_shifting_reg <= 1;
          state <= 4;
        end
        default: begin
          state <= 0;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      start_shifting_reg <= 0;
    end
    start_shifting <= start_shifting_reg;
  end

endmodule
