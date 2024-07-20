module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

   // Define states
   parameter START = 2'b00;
   parameter SHIFT_1 = 2'b01;
   parameter SHIFT_2 = 2'b10;
   parameter COUNT = 2'b11;

   // Define current state
   reg [1:0] state;

   // Sequential logic for state transitions
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= START;
      end else begin
         case(state)
            START: begin
               if (data == 4'b1101) begin
                  state <= SHIFT_1;
               end else begin
                  state <= START;
               end
            end
            SHIFT_1: begin
               state <= SHIFT_2;
            end
            SHIFT_2: begin
               state <= COUNT;
            end
            COUNT: begin
               if (done_counting) begin
                  state <= START;
               end else begin
                  state <= COUNT;
               end
            end
         endcase
      end
   end

   // Output logic
   always @(state) begin
      case(state)
         START: begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
         end
         SHIFT_1: begin
            shift_ena <= 1;
            counting <= 0;
            done <= 0;
         end
         SHIFT_2: begin
            shift_ena <= 1;
            counting <= 0;
            done <= 0;
         end
         COUNT: begin
            shift_ena <= 0;
            counting <= 1;
            done <= 0;
         end
         default: begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
         end
      endcase
   end

   // Wait for ack signal before resetting
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         done <= 0;
      end else if (state == START && ack) begin
         done <= 1;
      end
   end
endmodule
