module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  // Declare states
  reg [1:0] state, next_state;

  // Declare output
  reg out;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b0;  // Initialize state to OFF
    end
    else begin
      state <= next_state;
    end
  end

  always @(state or j or k) begin
    case (state)
      0: begin  // OFF state
        if (j) begin
          next_state = 2'b01;  // Transition to ON state when j=1
        end
        else begin
          next_state = 2'b00;  // Stay in OFF state when j=0
        end
        out = 1'b0;  // Set output to 0 in OFF state
      end

      1: begin  // ON state
        if (k) begin
          next_state = 2'b00;  // Transition to OFF state when k=1
        end
        else begin
          next_state = 2'b01;  // Stay in ON state when k=0
        end
        out = 1'b1;  // Set output to 1 in ON state
      end

      default: begin
        next_state = 2'b0;  // Default state to OFF
        out = 1'b0;  // Set output to 0 in default state
      end
    endcase
  end

endmodule
