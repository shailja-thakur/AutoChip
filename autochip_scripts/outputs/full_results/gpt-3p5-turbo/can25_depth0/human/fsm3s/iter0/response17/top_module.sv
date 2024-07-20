module top_module (
  input clk,
  input in,
  input reset,
  output out
);

reg [1:0] state;
reg out;
reg next_state;
 
always @(posedge clk, posedge reset) begin
  if(reset) begin
    state <= 2'b00; // Reset to state A
  end
  else begin
    state <= next_state;
  end
end
 
always @(*) begin
  case(state)
    2'b00: begin // State A
      if(in) begin
        next_state = 2'b01; // Next state = B
      end
      else begin
        next_state = 2'b00; // Next state = A
      end
      out = 1'b0; // Output = 0
    end
    2'b01: begin // State B
      if(in) begin
        next_state = 2'b01; // Next state = B
      end
      else begin
        next_state = 2'b10; // Next state = C
      end
      out = 1'b0; // Output = 0
    end
    2'b10: begin // State C
      if(in) begin
        next_state = 2'b11; // Next state = D
      end
      else begin
        next_state = 2'b00; // Next state = A
      end
      out = 1'b0; // Output = 0
    end
    2'b11: begin // State D
      if(in) begin
        next_state = 2'b10; // Next state = C
      end
      else begin
        next_state = 2'b01; // Next state = B
      end
      out = 1'b1; // Output = 1
    end
    default: begin
      next_state = 2'b00; // Default case
      out = 1'b0; // Default case
    end
  endcase
end

endmodule
