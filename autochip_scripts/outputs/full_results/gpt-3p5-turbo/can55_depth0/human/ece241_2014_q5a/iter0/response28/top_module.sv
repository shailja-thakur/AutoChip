module top_module (
  input clk,
  input areset,
  input x,
  output z
);
  
  reg [7:0] counter;            // Counter to keep track of the number of input bits
  reg [7:0] twos_complement;    // Output register for 2's complement
  reg [7:0] x_reg;              // Input register to store the current input bit
  
  parameter IDLE = 3'b000;      // IDLE state
  parameter CONVERT = 3'b001;   // CONVERT state
  
  reg [2:0] state;              // State register
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= IDLE;            // Reset the state machine to IDLE
      counter <= 0;             // Reset the counter
      twos_complement <= 0;     // Reset the output
    end else begin
      case (state)
        IDLE: begin
          if (!areset) begin
            if (x) begin
              state <= CONVERT;   // Transition to CONVERT state when x is high
              x_reg <= x;         // Store the current input bit
              twos_complement <= ~x_reg;   // Compute the 2's complement
              counter <= 1;       // Increase the counter to 1
            end
          end
        end
        CONVERT: begin
          if (counter < 7) begin
            state <= CONVERT;     // Stay in the CONVERT state
            x_reg <= x;           // Store the current input bit
            twos_complement <= twos_complement + (~x_reg << counter);   // Compute the 2's complement
            counter <= counter + 1;   // Increase the counter
          end else begin
            state <= IDLE;        // Transition back to IDLE state when counter reaches 7
          end
        end
        default: state <= IDLE;   // Default state transition to IDLE
      endcase
    end
  end
  
  assign z = twos_complement;    // Assign the output
  
endmodule
