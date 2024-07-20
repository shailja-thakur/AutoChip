module top_module (
   input clk,
   input j,
   input k,
   input reset,
   output reg out
);

   reg [1:0] state;

   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= 2'b00;    // Initialize state to A
      else begin
         case (state)
            2'b00: begin    // A state
               if (j)
                  state <= 2'b01;    // Next state B if j is high
               else
                  state <= 2'b00;    // Next state A if j is low
            end
            2'b01: begin    // B state
               if (k)
                  state <= 2'b00;    // Next state A if k is high
               else
                  state <= 2'b01;    // Next state B if k is low
            end
         endcase
      end
   end

   always @(*) begin
      if (state == 2'b01)
         out = 1'b1;    // Output high when state is B
      else
         out = 1'b0;    // Output low when state is A
   end

endmodule
