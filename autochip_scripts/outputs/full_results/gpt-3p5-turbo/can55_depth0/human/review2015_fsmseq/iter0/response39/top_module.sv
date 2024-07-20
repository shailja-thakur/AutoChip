module top_module (
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  // Internal state of the finite-state machine
  reg [3:0] state;

  // Finite-state machine states
  parameter IDLE = 0;
  parameter S1 = 1;
  parameter S2 = 2;
  parameter S3 = 3;
  parameter SUCCESS = 4;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      start_shifting <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data) begin
            state <= S1;
          end
        end
        S1: begin
          if (data) begin
            state <= S2;
          end else begin
            state <= IDLE;
          end
        end
        S2: begin
          if (data) begin
            state <= S3;
          end else begin
            state <= IDLE;
          end
        end
        S3: begin
          if (data) begin
            state <= SUCCESS;
            start_shifting <= 1;
          end else begin
            state <= IDLE;
          end
        end
        SUCCESS: begin
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
