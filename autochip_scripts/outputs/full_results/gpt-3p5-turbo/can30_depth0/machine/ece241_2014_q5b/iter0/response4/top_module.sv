module top_module (
    input clk,
    input areset,
    input x,
    output z
);

   reg [1:0] state;
   reg z;

   // State machine logic
   always @(posedge clk or posedge areset) begin
      if (areset) begin
         state <= 2'b00;  // Initialize state to A
         z <= 1'b0;
      end
      else begin
         case (state)
            2'b00: begin  // State A
               if (x)
                  state <= 2'b01;  // Next state is B if x is 1
               z <= (x) ? 1'b1 : 1'b0;
            end
            2'b01: begin  // State B
               state <= 2'b01;  // Next state is B
               z <= (x) ? 1'b0 : 1'b1;
            end
         endcase
      end
   end
   
endmodule
