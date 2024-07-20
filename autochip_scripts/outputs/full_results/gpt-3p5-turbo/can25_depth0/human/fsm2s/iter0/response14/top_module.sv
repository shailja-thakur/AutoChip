module top_module (
  input clk,       // Clock input
  input j,         // Input j
  input k,         // Input k
  input reset,     // Reset signal
  output reg out   // Output out
);
  
  // State enumeration
  parameter OFF = 1'b0;   // OFF state
  parameter ON = 1'b1;    // ON state
  
  reg [1:0] state;        // State register
  
  // Moore state machine logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= OFF;       // Reset to OFF state
    end else begin
      case (state)
        OFF: begin
          if (j) begin
            state <= ON;  // Transition to ON state if j is high
          end else begin
            state <= OFF; // Stay in OFF state if j is low
          end
        end
        ON: begin
          if (k) begin
            state <= OFF; // Transition to OFF state if k is high
          end else begin
            state <= ON;  // Stay in ON state if k is low
          end
        end
      endcase
    end
  end
  
  // Moore output logic
  always @(state) begin
    case (state)
      OFF: out = 1'b0;    // Output is 0 when in OFF state
      ON: out = 1'b1;     // Output is 1 when in ON state
    endcase
  end
  
endmodule
