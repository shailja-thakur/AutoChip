module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state
    );

   always @(posedge clk) begin
      if (reset)
         state <= 3'b000; // Reset to state B0
      else if (state == 3'b000) begin
         state <= 3'b001; // Transition from B0 to B1
         shift_ena <= 1;
      end
      else if (state == 3'b001) begin
         state <= 3'b010; // Transition from B1 to B2
         shift_ena <= 1;
      end
      else if (state == 3'b010) begin
         state <= 3'b011; // Transition from B2 to B3
         shift_ena <= 1;
      end
      else if (state == 3'b011) begin
         state <= 3'b100; // Transition from B3 to Done
         shift_ena <= 1;
      end
      else
         shift_ena <= 0; // No shift enabled in Done state
   end
endmodule
