module top_module(
   input wire clk,
   input wire reset,
   input wire data,
   output wire [3:0] count,
   output reg counting,
   output reg done,
   input wire ack 
);

// State definition
typedef enum logic [2:0] {
   IDLE,
   DETECT_1,
   DETECT_2,
   DETECT_3,
   COUNTING
} state_t;

// Input pattern definition
localparam DETECT_PATTERN = 4'b1101; 

// Internal state variables
reg [3:0] delay;
reg [2:0] currentState, nextState;
reg [3:0] counter;

always_ff @(posedge clk or posedge reset) begin
   if (reset) begin
      currentState <= IDLE;
      counter <= 0;
      counting <= 0;
      done <= 0;
      delay <= 0;
   end else begin
      currentState <= nextState;
      if (currentState == COUNTING) begin
         if (counter == (delay + 1) * 1000) begin
            counting <= 0;
            done <= 1;
         end else begin
            counter <= counter + 1;
         end
      end
   end
end

always_comb begin
   nextState = currentState;
   case (currentState)
      IDLE:
         if (data == DETECT_PATTERN) begin
            nextState = DETECT_1;
         end
      DETECT_1:
         nextState = DETECT_2;
      DETECT_2:
         nextState = DETECT_3;
      DETECT_3:
         begin
            delay = data;
            counting = 1;
            nextState = COUNTING;
         end
      COUNTING:
         begin
            counting = 1;
            if (counter == (delay + 1) * 1000) begin
               counter = 0;
               counting = 0;
               done = 1;
            end
         end
   endcase
end

// Output assignment
assign count = counting ? delay : 4'bzzzz;
assign done = done;

endmodule
