module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

reg [2:0] state;
 
always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 3'b000; // Reset to state A
  else begin
    case (state)
      3'b000: begin // State A
        if (w)
          state <= 3'b001; // Transition to state B
        else
          state <= 3'b000; // Transition to state A
      end
      
      3'b001: begin // State B
        if (w)
          state <= 3'b010; // Transition to state C
        else
          state <= 3'b010; // Transition to state D
      end
      
      3'b010: begin // State C
        if (w)
          state <= 3'b110; // Transition to state E
        else
          state <= 3'b010; // Transition to state D
      end
      
      3'b011: begin // State D
        if (w)
          state <= 3'b011; // Transition to state F
        else
          state <= 3'b000; // Transition to state A
      end
      
      3'b110: begin // State E
        if (w)
          state <= 3'b110; // Transition to state E
        else
          state <= 3'b011; // Transition to state F
      end
      
      3'b011: begin // State F
        if (w)
          state <= 3'b010; // Transition to state C
        else
          state <= 3'b011; // Transition to state F
      end
    endcase
  end
end

assign z = (state == 3'b110) || (state == 3'b011);

endmodule
