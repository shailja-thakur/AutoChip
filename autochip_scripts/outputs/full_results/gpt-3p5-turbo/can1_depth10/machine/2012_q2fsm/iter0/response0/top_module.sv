module top_module (
   input clk,
   input reset,
   input w,
   output reg z
);

   reg [2:0] state;
   always @(posedge clk) begin
      if (reset) begin
         state <= 3'b000;
      end else begin
         case (state)
            3'b000: begin
               if (w) begin
                  state <= 3'b001; // A to B transition
               end else begin
                  state <= 3'b000; // A to A transition
               end
            end
            3'b001: begin
               if (w) begin
                  state <= 3'b010; // B to C transition
               end else begin
                  state <= 3'b011; // B to D transition
               end
            end
            3'b010: begin
               if (w) begin
                  state <= 3'b100; // C to E transition
               end else begin
                  state <= 3'b011; // C to D transition
               end
            end
            3'b011: begin
               if (w) begin
                  state <= 3'b101; // D to F transition
               end else begin
                  state <= 3'b000; // D to A transition
               end
            end
            3'b100: begin
               if (w) begin
                  state <= 3'b100; // E to E transition
               end else begin
                  state <= 3'b011; // E to D transition
               end
            end
            3'b101: begin
               if (w) begin
                  state <= 3'b010; // F to C transition
               end else begin
                  state <= 3'b011; // F to D transition
               end
            end
         endcase
      end
   end

   // Output z is set to 1 when the state machine is in state E or F
   assign z = (state == 3'b100) || (state == 3'b101);

endmodule
