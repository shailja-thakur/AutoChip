module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

  reg [1:0] state;
  wire next_state;
  
  always @(posedge clk, posedge areset)
  begin
    if(areset)
      state <= 2'b00; // OFF state
    else
      state <= next_state;
  end
  
  always @(state, j, k)
  begin
    case(state)
      2'b00: // OFF state
        begin
          if(j)
            next_state = 2'b01; // Transition to ON state
          else
            next_state = 2'b00; // Remain in OFF state
          out = 1'b0; // Set output to 0
        end
      2'b01: // ON state
        begin
          if(k)
            next_state = 2'b00; // Transition to OFF state
          else
            next_state = 2'b01; // Remain in ON state
          out = 1'b1; // Set output to 1
        end
      default:
          next_state = 2'b00; // Default to OFF state
          out = 1'b0; // Set output to 0
    endcase
  end
  
endmodule
