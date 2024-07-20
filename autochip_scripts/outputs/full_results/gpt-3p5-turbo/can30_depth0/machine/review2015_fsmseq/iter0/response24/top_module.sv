module top_module(
   input clk,
   input reset,
   input data,
   output reg start_shifting
);

   reg [2:0] state;

   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= 3'b000;
      else begin
         case (state)
            3'b000: begin
               if (data)
                  state <= 3'b001;
               else
                  state <= 3'b000;
            end
            3'b001: begin
               if (data)
                  state <= 3'b010;
               else
                  state <= 3'b000;
            end
            3'b010: begin
               if (data)
                  state <= 3'b010;
               else
                  state <= 3'b011;
            end
            3'b011: begin
               if (data)
                  state <= 3'b100;
               else
                  state <= 3'b000;
            end
            default: state <= state;
         endcase
      end
   end

   always @(state) begin
      if (state == 3'b100)
         start_shifting <= 1'b1;
      else
         start_shifting <= 1'b0;
   end

endmodule
