module top_module(
   input wire clk,
   input wire reset,
   output reg [7:0] data_output,
   output reg valid_output
   );

   reg [7:0] state;
   reg [7:0] counter;

   parameter IDLE = 0;
   parameter WAIT = 1;
   parameter PROCESS = 2;
   parameter DONE = 3;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= IDLE;
         counter <= 0;
         data_output <= 0;
         valid_output <= 0;
      end
      else begin
         case (state)
            IDLE:
               begin
                  counter <= 0;
                  data_ouput <= 0;
                  state <= WAIT;
               end
            WAIT:
               begin
                  counter <= counter + 1;
                  data_output <= 0;
                  if (counter >= 10) begin
                     state <= PROCESS;
                  end
               end
            PROCESS:
               begin
                  data_output <= in;
                  state <= DONE;
               end
            DONE:
               begin
                  valid_output <= 1;
                  state <= IDLE;
               end
         endcase
      end
   end

endmodule
