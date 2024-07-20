module top_module (
   input clk,
   input resetn,
   input [3:1] r,
   output [3:1] g
);

   reg [3:1] state;
   reg [3:1] next_state;

   always @(posedge clk or negedge resetn)
      if (~resetn)
         state <= 3'b000;
      else
         state <= next_state;

   always @(state or r)
      case (state)
         3'b000: begin
            if (r[1]) next_state = 3'b001;
            else if (r[2]) next_state = 3'b010;
            else if (r[3]) next_state = 3'b100;
            else next_state = 3'b000;
         end
         3'b001: begin
            if (r[1]) next_state = 3'b001;
            else if (r[2]) next_state = 3'b010;
            else if (r[3]) next_state = 3'b100;
            else next_state = 3'b000;
         end
         3'b010: begin
            if (r[1]) next_state = 3'b001;
            else if (r[2]) next_state = 3'b010;
            else if (r[3]) next_state = 3'b100;
            else next_state = 3'b000;
         end
         3'b100: begin
            if (r[1]) next_state = 3'b001;
            else if (r[2]) next_state = 3'b010;
            else if (r[3]) next_state = 3'b100;
            else next_state = 3'b000;
         end
         default: next_state = 3'b000;
      endcase

   always @(state)
      case (state)
         3'b000: g = 3'b000;
         3'b001: g = 3'b001;
         3'b010: g = 3'b010;
         3'b100: g = 3'b100;
         default: g = 3'b000;
      endcase

endmodule
