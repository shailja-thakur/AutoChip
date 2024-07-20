module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;
  reg [3:0] next_next_state; // Added next_next_state for proper state transition

  // Define state values
  parameter IDLE = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0100;
  parameter S4 = 4'b1000;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      start_shifting <= 0;
    end
    else begin
      state <= next_state;
      next_state <= next_next_state; // Assign next_next_state to next_state

      case (state)
        IDLE: begin
          if (data) begin
            next_next_state <= S1; // Set next_next_state to S1
          end
          else begin
            next_next_state <= IDLE;
          end
        end
        S1: begin
          if (data) begin
            next_next_state <= S1;
          end
          else begin
            next_next_state <= S2;
          end
        end
        S2: begin
          if (data) begin
            next_next_state <= S1;
          end
          else if (!data) begin
            next_next_state <= S3;
          end
        end
        S3: begin
          if (data) begin
            next_next_state <= S4;
          end
          else if (!data) begin
            next_next_state <= S2;
          end
        end
        S4: begin
          if (data) begin
            next_next_state <= S1;
            start_shifting <= 1;
          end
          else begin
            next_next_state <= S2;
          end
        end
      endcase
    end
  end
endmodule
