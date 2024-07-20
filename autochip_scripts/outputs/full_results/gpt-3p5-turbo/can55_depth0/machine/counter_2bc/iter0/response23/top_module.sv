module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
  
  // Declare the internal state variable
  logic [1:0] current_state;
  
  // Define the states
  parameter [1:0] STATE_0 = 2'b00;
  parameter [1:0] STATE_1 = 2'b01;
  parameter [1:0] STATE_2 = 2'b10;
  parameter [1:0] STATE_3 = 2'b11;
  
  // State register
  always_ff @(posedge clk or negedge areset) begin
    if (!areset) begin
      current_state <= STATE_1;
    end else begin
      case (current_state)
        STATE_0: begin
          if (train_taken && current_state != STATE_3) begin
            current_state <= current_state + 1;
          end else if (!train_taken && current_state != STATE_0) begin
            current_state <= current_state - 1;
          end
        end
        STATE_1: begin
          if (!areset) begin
            current_state <= STATE_1;
          end else if (train_valid) begin
            current_state <= STATE_0;
          end
        end
        STATE_2: begin
          if (train_taken && current_state != STATE_3) begin
            current_state <= current_state + 1;
          end else if (!train_taken && current_state != STATE_0) begin
            current_state <= current_state - 1;
          end
        end
        STATE_3: begin
          if (train_taken && current_state != STATE_3) begin
            current_state <= current_state + 1;
          end else if (!train_taken && current_state != STATE_0) begin
            current_state <= current_state - 1;
          end
        end
      endcase
    end
  end
  
  // Assign the current state to the output
  assign state = current_state;
  
endmodule
