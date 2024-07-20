module top_module(
  input wire clk,
  input wire reset,
  output reg out,
  output reg valid);
  
  reg [1:0] state;
  reg [7:0] counter;
  
  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else 
      case (state)
        IDLE:
          begin
            counter <= 0;
            out <= 0;
            valid <= 0;
            if (in)
              state <= WAIT;
          end
        WAIT:
          begin
            counter <= counter + 1;
            out <= 0;
            valid <= 0;
            if (counter == 5'b10000)
              state <= PROCESS;
          end
        PROCESS:
          begin
            out <= in;
            state <= DONE;
          end
        DONE:
          begin
            valid <= 1;
            state <= IDLE;
          end
      endcase
  end
endmodule
