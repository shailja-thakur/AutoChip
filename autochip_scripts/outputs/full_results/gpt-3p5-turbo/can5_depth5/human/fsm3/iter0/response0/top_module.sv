module top_module (
    input clk,
    input in,
    input areset,
    output out
);
  
  reg [1:0] state, next_state;
  reg out_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00; // Reset state to A
    else
      state <= next_state; // Update state based on next_state value
  end
  
  always @(state, in) begin
    case (state)
      2'b00: begin // State A
        if (in)
          next_state = 2'b01; // Next state is B when in=1
        else
          next_state = 2'b00; // Next state is A when in=0
        out_reg = 1'b0; // Output is 0
      end
      2'b01: begin // State B
        if (in)
          next_state = 2'b01; // Next state is B when in=1
        else
          next_state = 2'b10; // Next state is C when in=0
        out_reg = 1'b0; // Output is 0
      end
      2'b10: begin // State C
        if (in)
          next_state = 2'b11; // Next state is D when in=1
        else
          next_state = 2'b00; // Next state is A when in=0
        out_reg = 1'b0; // Output is 0
      end
      2'b11: begin // State D
        if (in)
          next_state = 2'b01; // Next state is B when in=1
        else
          next_state = 2'b10; // Next state is C when in=0
        out_reg = 1'b1; // Output is 1
      end
      default: begin
        next_state = 2'b00; // Default next state is A
        out_reg = 1'b0; // Default output is 0
      end
    endcase
  end
 
  always @(posedge clk) begin
    out <= out_reg; // Synchronous assign output
  end

endmodule
