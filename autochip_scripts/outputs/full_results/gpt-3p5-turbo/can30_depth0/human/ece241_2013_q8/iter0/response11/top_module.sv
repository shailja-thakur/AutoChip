module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      state <= 2'b00; // Reset to initial state
      z <= 1'b0; // Reset output signal
    end
    else begin
      state <= next_state;
      z <= 1'b0; // Default output signal to 0
    end
  end

  always @(state or x) begin
    case (state)
      2'b00: begin // State 0
        if (x) begin
          next_state = 2'b01; // Transition to state 1
        end
        else begin
          next_state = 2'b00; // Stay in state 0
        end
      end

      2'b01: begin // State 1
        if (x) begin
          next_state = 2'b10; // Transition to state 2
        end
        else begin
          next_state = 2'b00; // Restart detection
        end
      end

      2'b10: begin // State 2
        if (x) begin
          next_state = 2'b10; // Stay in state 2
        end
        else begin
          next_state = 2'b00; // Reset detection
        end
      end
    endcase
  end

  always @(state) begin
    case (state)
      2'b10: begin // State 2
        z <= 1'b1; // Output signal 1 when "101" sequence is detected
      end

      default: begin
        z <= 1'b0;
      end
    endcase
  end

endmodule
