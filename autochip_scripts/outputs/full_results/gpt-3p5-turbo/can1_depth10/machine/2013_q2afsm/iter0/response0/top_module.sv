module top_module (
   input clk,
   input resetn,
   input [2:0] r,
   output reg [2:0] g
);

   reg [1:0] state;
   reg [1:0] next_state;

   always @(posedge clk) begin
      if (!resetn)
         state <= 2'b0;
      else
         state <= next_state;
   end

   always @(state or r) begin
      case (state)
         2'b0: begin
            if (r[0])
               next_state = 2'b10;
            else if (r[1])
               next_state = 2'b1;
            else if (r[2])
               next_state = 2'b11;
            else
               next_state = 2'b0;
         end
         2'b1: begin
            if (r[0])
               next_state = 2'b1;
            else
               next_state = 2'b0;
         end
         2'b10: begin
            if (r[1])
               next_state = 2'b10;
            else
               next_state = 2'b0;
         end
         2'b11: begin
            if (r[2])
               next_state = 2'b11;
            else
               next_state = 2'b0;
         end
         default: next_state = 2'b0;
      endcase
   end

   always @(state) begin
      case (state)
         2'b01: g = 3'b001;
         2'b10: g = 3'b010;
         2'b11: g = 3'b100;
         default: g = 3'b000;
      endcase
   end

endmodule
