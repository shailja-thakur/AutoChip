module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

   // State Declaration
   typedef enum reg [2:0] {
       B0 = 3'b000,
       B1 = 3'b001,
       B2 = 3'b010,
       B3 = 3'b011,
       Done = 3'b100
   } state_t;
   
   reg [2:0] state;
   
   always @(posedge clk or posedge reset) begin
       if (reset)
           state <= B0;  // When reset is 1, go to state B0
       else begin
           case (state)
               B0: state <= B1;  // State transition from B0 to B1
               B1: state <= B2;  // State transition from B1 to B2
               B2: state <= B3;  // State transition from B2 to B3
               B3: state <= Done;  // State transition from B3 to Done
               default: state <= Done;  // For any other state, go to Done
           endcase
       end
   end

   // shift_ena is 1 if state is B0, B1, B2, or B3, otherwise it is 0
   assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);

endmodule
