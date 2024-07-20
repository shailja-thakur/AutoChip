module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg reset_edge;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
      reset_edge <= 1;
    end else begin
      reset_edge <= 0;
      case(state)
        0: begin // Initial state
          if (data) begin
            state <= 1;
          end else begin
            state <= 0;
          end
        end
        1: begin // State after receiving 1
          if (data) begin
            state <= 1;
          end else begin
            state <= 2;
          end
        end
        2: begin // State after receiving 11
          if (data) begin
            state <= 3;
          end else begin
            state <= 0;
          end
        end
        3: begin // State after receiving 110
          if (data) begin
            state <= 3;
          end else begin
            state <= 4;
          end
        end
        4: begin // State after receiving 1101
          if (data) begin
            state <= 3;
          end else begin
            state <= 4;
            if (reset_edge) begin
              start_shifting <= 1;
            end else begin
              start_shifting <= 0;
            end
          end
        end
      endcase
    end
  end

endmodule
