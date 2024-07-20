module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);

reg [1:0] current_state;

always @(state or in) begin
  case (state)
    2'b00: begin // State A
      if (in)
        next_state = 2'b01; // Next state B
      else
        next_state = 2'b00; // Next state A
    end
    
    2'b01: begin // State B
      if (in)
        next_state = 2'b01; // Next state B
      else
        next_state = 2'b10; // Next state C
    end
    
    2'b10: begin // State C
      if (in)
        next_state = 2'b11; // Next state D
      else
        next_state = 2'b00; // Next state A
    end
    
    2'b11: begin // State D
      if (in)
        next_state = 2'b01; // Next state B
      else
        next_state = 2'b10; // Next state C
    end
  endcase
end

always @(posedge clk) begin
  current_state <= next_state;
end

assign out = (current_state == 2'b11) ? 1'b1 : 1'b0;

endmodule
