module top_module (
   input clk,
   input reset,
   input [3:1] s,
   output reg fr3,
   output reg fr2,
   output reg fr1,
   output reg dfr
);

reg [3:1] prev_s;
reg [1:0] state;

parameter ABOVE_S3 = 3'b000;
parameter BETWEEN_S3_S2 = 3'b010;
parameter BETWEEN_S2_S1 = 3'b100;
parameter BELOW_S1 = 3'b110;

always @(posedge clk) begin
   if (reset) begin
      state <= BELOW_S1;
      fr3 <= 1'b1;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      dfr <= 1'b1;
   end else begin
      prev_s <= s;
      case (state)
         ABOVE_S3: 
            if (s[3])
               state <= BETWEEN_S3_S2; // Transition to next state
            else begin
               state <= ABOVE_S3; // Stay in current state
               dfr <= 1'b0; // Close Supplemental flow valve
            end
         BETWEEN_S3_S2: 
            if (s[2])
               state <= BETWEEN_S2_S1; // Transition to next state
            else begin
               state <= ABOVE_S3; // Transition back to previous state
               dfr <= 1'b0; // Close Supplemental flow valve
            end
         BETWEEN_S2_S1: 
            if (s[1])
               state <= BELOW_S1; // Transition to next state
            else begin
               state <= BETWEEN_S2_S1; // Stay in current state
               dfr <= 1'b1; // Open Supplemental flow valve
            end
         BELOW_S1:
            if (!s[1])
               state <= BETWEEN_S2_S1; // Transition to next state
            else begin
               state <= BELOW_S1; // Stay in current state
               dfr <= 1'b1; // Open Supplemental flow valve
            end
      endcase

      // Set flow rate based on current state
      case (state)
         ABOVE_S3:
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
         BETWEEN_S3_S2:
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b1;
         BETWEEN_S2_S1:
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
         BELOW_S1:
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
      endcase
   end
end

endmodule
