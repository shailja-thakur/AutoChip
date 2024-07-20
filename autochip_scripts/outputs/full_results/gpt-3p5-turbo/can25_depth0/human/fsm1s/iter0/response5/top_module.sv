module top_module (
  input clk,
  input in,
  input reset,
  output out
);
  
  reg [1:0] state, next_state;
  reg out_reg;
  
  // Initial state assignment
  initial begin
    state = 2'b0;
    out_reg = 1'b1;
  end

  // Synchronous reset
  always @(posedge clk) begin
    if (reset)
      state <= 2'b0;
    else
      state <= next_state;
      
    case(state)
      // State B
      2'b0: begin
        if (in)
          next_state = 2'b0;
        else
          next_state = 2'b1;
        out_reg <= 1'b1;
      end
      
      // State A
      2'b1: begin
        if (in)
          next_state = 2'b1;
        else
          next_state = 2'b0;
        out_reg <= 1'b0;
      end
    endcase
  end

  assign out = out_reg;
  
endmodule
