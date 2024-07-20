module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);
  
  // Define the states
  parameter OFF = 0;
  parameter ON = 1;
  
  // Define the state register
  reg [1:0] state;
  
  // Synchronous reset to state OFF
  always @(posedge clk) begin
    if (reset)
      state <= OFF;
    else begin
      // State transition logic
      case(state)
        OFF: begin
          if (j)
            state <= ON;
          else
            state <= OFF;
        end
        ON: begin
          if (k)
            state <= OFF;
          else
            state <= ON;
        end
        default: state <= OFF;
      endcase
    end
  end
  
  // Output assignment
  always @(state) begin
    case(state)
      OFF: out = 0;
      ON: out = 1;
      default: out = 0;
    endcase
  end
  
endmodule
