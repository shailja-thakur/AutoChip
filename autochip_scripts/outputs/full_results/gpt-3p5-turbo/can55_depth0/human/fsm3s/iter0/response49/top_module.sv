module top_module (
	input clk,
	input in,
	input reset,
	output out
);
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;     // Reset to state A
    else begin
      case (state)
        2'b00: begin        // State A
          if (in)
            state <= 2'b01; // Next state in=1: B
          else
            state <= 2'b00; // Next state in=0: A
        end
        2'b01: begin        // State B
          if (in)
            state <= 2'b01; // Next state in=1: B
          else
            state <= 2'b10; // Next state in=0: C
        end
        2'b10: begin        // State C
          if (in)
            state <= 2'b00; // Next state in=1: A
          else
            state <= 2'b11; // Next state in=0: D
        end
        2'b11: begin        // State D
          if (in)
            state <= 2'b10; // Next state in=1: C
          else
            state <= 2'b01; // Next state in=0: B
        end
      endcase
    end
  end
  
  always @(state) begin
    case (state)
      2'b00: out = 1'b0;   // Output in state A: 0
      2'b01: out = 1'b0;   // Output in state B: 0
      2'b10: out = 1'b0;   // Output in state C: 0
      2'b11: out = 1'b1;   // Output in state D: 1
    endcase
  end
  
endmodule
