module top_module (
   input clk,
   input reset,
   input x,
   output reg z
);

   reg [2:0] state;
   wire x_high;
   wire x_low;
   
   assign x_high = (x == 1'b1);
   assign x_low = (x == 1'b0);
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 3'b001; // initial state is A
         z <= 1'b0;
      end else begin
         case (state)
            3'b000: begin // state A
               if (x_low) begin
                  state <= 3'b000; // Next state is A
               end else begin
                  state <= 3'b001; // Next state is B
               end
            end
            
            3'b001: begin // state B
               if (x_low) begin
                  state <= 3'b001; // Next state is B
               end else begin
                  state <= 3'b100; // Next state is E
               end
            end
            
            3'b010: begin // state C
               if (x_low) begin
                  state <= 3'b010; // Next state is C
               end else begin
                  state <= 3'b001; // Next state is B
               end
            end
            
            3'b011: begin // state D
               if (x_low) begin
                  state <= 3'b001; // Next state is B
               end else begin
                  state <= 3'b010; // Next state is C
               end
            end
            
            3'b100: begin // state E
               if (x_low) begin
                  state <= 3'b011; // Next state is D
               end else begin
                  state <= 3'b100; // Next state is E
               end
            end
         endcase
         
         if (state == 3'b100 || state == 3'b101) begin // state D or E
            z <= 1'b1;
         end else begin
            z <= 1'b0;
         end
      end
   end
endmodule
