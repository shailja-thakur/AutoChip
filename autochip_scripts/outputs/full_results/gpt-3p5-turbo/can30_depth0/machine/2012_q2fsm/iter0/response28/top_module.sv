module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // Initial state is A
    else begin
      case ({state, w})
        // State transitions when w=0
        2'b00: state <= 3'b000; // A -> A
        2'b01: state <= 3'b100; // B -> D
        2'b10: state <= 3'b100; // C -> D
        2'b11: state <= 3'b000; // D -> A
        
        // State transitions when w=1
        2'b01: state <= 3'b001; // A -> B
        2'b10: state <= 3'b010; // B -> C
        2'b00: state <= 3'b110; // C -> E
        2'b11: state <= 3'b111; // D -> F
        2'b01: state <= 3'b010; // E -> E
        2'b10: state <= 3'b100; // F -> C
        default: state <= 3'bxxx; // Should never happen
      endcase
    end
  end

  assign z = (state == 3'b110) || (state == 3'b111); // Set z to 1 when state is E or F

endmodule
