module top_module (
   input clk,
   input x,
   input [2:0] y,
   output reg [2:0] Y,
   output reg z
);

   reg [2:0] next_state;
   
   always @(posedge clk) begin
      case ({x, y})
         3'b000: next_state <= 3'b000;
         3'b001: next_state <= 3'b001;
         3'b010: next_state <= 3'b001;
         3'b011: next_state <= 3'b010;
         3'b100: next_state <= 3'b100;
         default: next_state <= 3'b000;
      endcase
   end

   always @(posedge clk) begin
      case (next_state)
         3'b000: begin
            Y <= 3'b000;
            z <= 1'b0;
         end
         3'b001: begin
            Y <= 3'b100;
            z <= 1'b0;
         end
         3'b010: begin
            Y <= 3'b001;
            z <= 1'b0;
         end
         3'b100: begin
            Y <= 3'b011;
            z <= 1'b1;
         end
         default: begin
            Y <= 3'b000;
            z <= 1'b0;
         end
      endcase
   end
endmodule
