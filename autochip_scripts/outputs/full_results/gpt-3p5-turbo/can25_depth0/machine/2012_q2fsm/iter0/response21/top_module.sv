module top_module (
	input wire clk,
	input wire reset,
	input wire w,
	output wire z
);

  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // initial state A
    else begin
      case (state)
        3'b000: // state A
          if (w)
            state <= 3'b001; // transition to state B
          else
            state <= 3'b000; // stay in state A
          
        3'b001: // state B
          if (w)
            state <= 3'b010; // transition to state C
          else
            state <= 3'b100; // transition to state D
          
        3'b010: // state C
          if (w)
            state <= 3'b100; // transition to state E
          else
            state <= 3'b100; // stay in state C
          
        3'b100: // state D
          if (w)
            state <= 3'b011; // transition to state F
          else
            state <= 3'b000; // transition to state A
          
        3'b011: // state E
          if (w)
            state <= 3'b011; // stay in state E
          else
            state <= 3'b100; // transition to state D
          
        3'b101: // state F
          if (w)
            state <= 3'b010; // transition to state C
          else
            state <= 3'b100; // transition to state D
      endcase
    end
  end

  assign z = (state == 3'b011) || (state == 3'b101); // set z to 1 when state is E or F

endmodule
