module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
  
  // Internal state signal
  logic [1:0] current_state;
  
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset state to 1
      current_state <= 2'b01;
    end else begin
      // Transition between states based on inputs
      case (current_state)
        2'b00: begin
          if (train_valid && train_taken) begin
            current_state <= 2'b01;  // Next state
          end else begin
            current_state <= 2'b00;  // Remain in current state
          end
        end
        2'b01: begin
          if (train_valid && train_taken) begin
            current_state <= 2'b10;  // Next state
          end else begin
            current_state <= 2'b00;  // Previous state
          end
        end
        2'b10: begin
          if (train_valid && train_taken) begin
            current_state <= 2'b11;  // Next state
          end else begin
            current_state <= 2'b01;  // Previous state
          end
        end
        2'b11: begin
          if (train_valid && train_taken) begin
            current_state <= 2'b11;  // Remain in current state
          end else begin
            current_state <= 2'b10;  // Previous state
          end
        end
      endcase
    end
  end
  
  // Assign current_state to output
  assign state = current_state;
  
endmodule
