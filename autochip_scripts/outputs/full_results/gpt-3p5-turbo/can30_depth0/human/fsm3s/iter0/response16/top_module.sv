module moore_state_machine (
   input clk,
   input in,
   input reset,
   output reg out
);

   reg [1:0] state;
   reg [1:0] next_state;

   // State assignments
   parameter A = 2'b00;
   parameter B = 2'b01;
   parameter C = 2'b10;
   parameter D = 2'b11;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= A;
      end
      else begin
         state <= next_state;
      end
   end

   always @(*) begin
      case(state)
         A: begin
            if (in) begin
               next_state = B;
            end
            else begin
               next_state = A;
            end
            out = 0;
         end
         B: begin
            if (in) begin
               next_state = B;
            end
            else begin
               next_state = C;
            end
            out = 0;
         end
         C: begin
            if (in) begin
               next_state = D;
            end
            else begin
               next_state = A;
            end
            out = 0;
         end
         D: begin
            if (in) begin
               next_state = B;
            end
            else begin
               next_state = C;
            end
            out = 1;
         end
         default: begin
            next_state = A;
            out = 0;
         end
      endcase
   end

endmodule
module top_module (
   input clk,
   input in,
   input reset,
   output out
);

   moore_state_machine fsm (
      .clk(clk),
      .in(in),
      .reset(reset),
      .out(out)
   );

endmodule
