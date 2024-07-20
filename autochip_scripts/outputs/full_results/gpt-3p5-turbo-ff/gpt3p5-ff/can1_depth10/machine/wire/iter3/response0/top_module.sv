module top_module(
  input wire clock,
  input wire reset,
  input wire in,
  output wire out);
  
  reg [1:0] state;
  reg [7:0] counter;
  
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;
  
  always @(posedge clock or posedge reset) begin
    if (reset)
      state <= IDLE;
    else begin
      case (state)
        IDLE: begin
          counter <= 0;
          out <= 0;
          state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          out <= 0;
          if (counter == 8)
            state <= PROCESS;
        end
        PROCESS: begin
          out <= in;
          state <= DONE;
        end
        DONE: begin
          out <= 0;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
