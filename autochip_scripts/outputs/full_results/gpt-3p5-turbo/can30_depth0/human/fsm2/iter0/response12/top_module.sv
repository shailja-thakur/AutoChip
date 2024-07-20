module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  // Define the states
  parameter OFF = 1'b0;
  parameter ON = 1'b1;

  // Define the current state and next state
  reg state, next_state;
  
  // Define the output
  wire out;

  // Instantiate the state machine
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= OFF;
    end else begin
      state <= next_state;
    end
  end

  // Define the combinational logic for next state and output
  always @(state or j or k) begin
    case (state)
      OFF: begin
        if (j) begin
          next_state = ON;
          out = 1'b0;
        end else begin
          next_state = OFF;
          out = 1'b0;
        end
      end
      
      ON: begin
        if (k) begin
          next_state = OFF;
          out = 1'b1;
        end else begin
          next_state = ON;
          out = 1'b1;
        end
      end
    endcase
  end

endmodule
