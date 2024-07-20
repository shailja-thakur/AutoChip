module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);

  // Define states
  localparam OFF = 0;
  localparam ON = 1;

  // Define current state variable
  reg [1:0] state;

  // Synchronous reset to state OFF
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= OFF;
    else begin
      // Next state logic
      case (state)
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
      endcase
    end
  end

  // Output logic
  always @(state) begin
    case (state)
      OFF: out <= 0;
      ON: out <= 1;
    endcase
  end

endmodule
