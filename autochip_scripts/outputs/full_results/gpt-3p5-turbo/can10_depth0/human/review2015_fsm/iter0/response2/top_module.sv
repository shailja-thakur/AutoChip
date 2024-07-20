module top_module(
	input clk,
	input reset,
	input data,
   output reg shift_ena,
   output reg counting,
   input done_counting,
   output reg done,
   input ack );
   
   // Define the states of the state machine
   typedef enum logic [2:0] {
      IDLE,
      DETECTED,
      SHIFTING,
      WAITING,
      TIMEOUT,
      RESET
   } state_t;

   // Create a register to hold the current state
   reg [2:0] currentState;
   // Create a register to hold the next state
   reg [2:0] nextState;
   
   // Initialize the current state to the RESET state
   initial begin
      currentState = RESET;
   end
   
   // Always block to handle the state transitions and outputs
   always @(posedge clk or posedge reset) begin
      // On reset, set the current state to the RESET state
      if (reset) begin
         currentState <= RESET;
      end
      // Otherwise, handle the state transitions and outputs
      else begin
         // Set the next state based on the current state
         case (currentState)
            IDLE: begin
               if (data[3:0] == 4'b1101) begin
                  nextState = DETECTED;
               end else begin
                  nextState = IDLE;
               end
            end
            DETECTED: begin
               nextState = SHIFTING;
            end
            SHIFTING: begin
               nextState = WAITING;
            end
            WAITING: begin
               if (done_counting) begin
                  nextState = TIMEOUT;
               end else begin
                  nextState = WAITING;
               end
            end
            TIMEOUT: begin
               if (ack) begin
                  nextState = RESET;
               end else begin
                  nextState = TIMEOUT;
               end
            end
            RESET: begin
               nextState = IDLE;
            end
            default: nextState = IDLE;
         endcase

         // Update the current state with the next state
         currentState <= nextState;
      end
   end

   // Assign the outputs based on the current state
   always @(currentState) begin
      case (currentState)
         IDLE: begin
            shift_ena = 1'b0;
            counting = 1'b0;
            done = 1'b0;
         end
         DETECTED: begin
            shift_ena = 1'b1;
            counting = 1'b0;
            done = 1'b0;
         end
         SHIFTING: begin
            shift_ena = 1'b1;
            counting = 1'b0;
            done = 1'b0;
         end
         WAITING: begin
            shift_ena = 1'b0;
            counting = 1'b1;
            done = 1'b0;
         end
         TIMEOUT: begin
            shift_ena = 1'b0;
            counting = 1'b0;
            done = 1'b1;
         end
         RESET: begin
            shift_ena = 1'b0;
            counting = 1'b0;
            done = 1'b0;
         end
         default: begin
            shift_ena = 1'b0;
            counting = 1'b0;
            done = 1'b0;
         end
      endcase
   end
endmodule
