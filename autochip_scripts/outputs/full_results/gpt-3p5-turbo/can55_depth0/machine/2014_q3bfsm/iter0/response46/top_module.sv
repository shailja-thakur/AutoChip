module top_module (
   input clk,
   input reset,
   input x,
   output reg z
);

   reg [2:0] state;

   always @(posedge clk or posedge reset) begin
      if(reset)
         state <= 3'b000;  // Initialize state to A
      else begin
         case(state)
            3'b000: if(x) state <= 3'b001; else state <= 3'b000; // State A
            3'b001: if(x) state <= 3'b100; else state <= 3'b001; // State B
            3'b010: if(x) state <= 3'b001; else state <= 3'b010; // State C
            3'b011: if(x) state <= 3'b100; else state <= 3'b011; // State D
            3'b100: if(x) state <= 3'b100; else state <= 3'b011; // State E
            default: state <= 3'b000; // Default to state A
         endcase
      end
   end

   always @(state, x) begin
      case(state)
         3'b011, 3'b100: z <= 1'b1; // Output is high in states D and E
         default: z <= 1'b0; // Output is low in all other states
      endcase
   end

endmodule
