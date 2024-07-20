module top_module(
  input wire clock,
  input wire reset,
  input wire in,
  output reg out,
  output reg valid_output);
  
  reg [1:0] state;
  reg [7:0] counter;
  
  parameter IDLE = 0;
  parameter WAIT = 1;
  parameter PROCESS = 2;
  parameter DONE = 3;
  
  always @(posedge clock or posedge reset) begin
    if (reset)
      state <= IDLE;
    else begin
      case (state)
        IDLE: begin
          counter <= 0;
          out <= 0;
          valid_output <= 0;
          if (reset)
            state <= IDLE;
          else
            state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          out <= 0;
          valid_output <= 0;
          if (counter == 8)
            state <= PROCESS;
          else
            state <= WAIT;
        end
        PROCESS: begin
          out <= in;
          valid_output <= 1;
          state <= DONE;
        end
        DONE: begin
          out <= 0;
          valid_output <= 0;
          state <= IDLE;
        end
        default: state <= IDLE;
      endcase
    end
  end

endmodule
