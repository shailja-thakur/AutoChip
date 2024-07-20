module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b10;  // Reset state B
    else begin
      case (state)
        0: // State A
          if (in) 
            state <= 2'b11;  // Next state A
          else
            state <= 2'b10;  // Next state B
          
        1: // State B
          if (in)
            state <= 2'b01;  // Next state B
          else
            state <= 2'b00;  // Next state A
      endcase
    end
  end
  
  assign out = (state == 2'b00) ? 1'b0 : 1'b1;
  
endmodule
