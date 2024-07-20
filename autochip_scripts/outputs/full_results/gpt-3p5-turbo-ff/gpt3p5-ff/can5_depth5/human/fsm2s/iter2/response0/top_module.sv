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
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= OFF;
    end else begin
      // State transition logic
      case(state)
        OFF: begin
          if (j) begin
            state <= ON;
          end else begin
            state <= OFF;
          end
        end
        ON: begin
          if (k) begin
            state <= OFF;
          end else begin
            state <= ON;
          end
        end
        default: state <= OFF;
      endcase
    end
  end
  
  // Output assignment
  always @(state) begin
    case(state)
      OFF: begin
        out <= 0;
      end
      ON: begin
        out <= 1;
      end
      default: begin
        out <= 0;
      end
    endcase
  end
  
endmodule
