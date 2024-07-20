module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
  
  // Define the states
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;
  
  // Variables to hold the current and next states
  reg [1:0] current_state;
  reg [1:0] next_state;
  
  // State machine logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset state machine to state 1
      current_state <= S1;
    end else begin
      // Update state machine based on inputs
      case (current_state)
        S0: begin
          if (train_valid) begin
            if (train_taken) begin
              next_state <= S1;
            end else begin
              next_state <= S0;
            end
          end else begin
            next_state <= S0;
          end
        end
        S1: begin
          if (train_valid) begin
            if (train_taken) begin
              if (current_state < S3) begin
                next_state <= current_state + 1;
              end else begin
                next_state <= current_state;
              end
            end else begin
              if (current_state > S0) begin
                next_state <= current_state - 1;
              end else begin
                next_state <= current_state;
              end
            end
          end else begin
            next_state <= current_state;
          end
        end
        S2: begin
          if (train_valid) begin
            if (train_taken) begin
              if (current_state < S3) begin
                next_state <= current_state + 1;
              end else begin
                next_state <= current_state;
              end
            end else begin
              if (current_state > S0) begin
                next_state <= current_state - 1;
              end else begin
                next_state <= current_state;
              end
            end
          end else begin
            next_state <= current_state;
          end
        end
        S3: begin
          if (train_valid) begin
            if (train_taken) begin
              next_state <= S3;
            end else begin
              next_state <= S2;
            end
          end else begin
            next_state <= S3;
          end
        end
      endcase
    end
  end
  
  // Assign the current state to the output
  always @(posedge clk) begin
    state <= current_state;
  end
  
endmodule
