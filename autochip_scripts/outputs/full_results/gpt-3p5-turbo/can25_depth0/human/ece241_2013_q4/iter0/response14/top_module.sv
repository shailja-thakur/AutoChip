module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] current_state;
reg [3:1] next_state;

always @(posedge clk or posedge reset) begin
   if (reset) begin
      current_state <= 0;
   end else begin
      current_state <= next_state;
   end
end

always @(current_state, s) begin
   case (current_state)
      0: begin  // state when water level is low for a long time 
         fr1 <= 1'b1;
         fr2 <= 1'b1;
         fr3 <= 1'b1;
         dfr <= 1'b1;
         if (s[1] && !s[2] && !s[3])
            next_state <= 1;    // transition to state 1 if s[1] is asserted
         else
            next_state <= 0;    // stay in state 0 otherwise
      end
      1: begin  // state when water level is between s[1] and s[2]
         fr1 <= 1'b1;
         fr2 <= 1'b1;
         fr3 <= 1'b0;
         dfr <= 1'b1;
         if (!s[1] && s[2] && !s[3])
            next_state <= 2;    // transition to state 2 if s[2] is asserted
         else if (s[1] && !s[2] && !s[3])
            next_state <= 0;    // transition back to state 0 if s[1] is asserted
         else
            next_state <= 1;    // stay in state 1 otherwise
      end
      2: begin  // state when water level is between s[2] and s[3]
         fr1 <= 1'b1;
         fr2 <= 1'b0;
         fr3 <= 1'b0;
         dfr <= 1'b1;
         if (!s[1] && !s[2] && s[3])
            next_state <= 3;    // transition to state 3 if s[3] is asserted
         else if (!s[1] && s[2] && !s[3])
            next_state <= 1;    // transition back to state 1 if s[2] is asserted
         else
            next_state <= 2;    // stay in state 2 otherwise
      end
      3: begin  // state when water level is above s[3]
         fr1 <= 1'b0;
         fr2 <= 1'b0;
         fr3 <= 1'b0;
         dfr <= 1'b0;
         if (!s[1] && !s[2] && !s[3])
            next_state <= 0;    // transition back to state 0 if no sensors are asserted
         else
            next_state <= 3;    // stay in state 3 otherwise
      end
   endcase
end

endmodule
