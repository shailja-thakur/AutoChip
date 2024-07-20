module top_module(
  input clk,
  input reset,
  output reg data_out,
  output reg valid
);
  reg [1:0] state;
  reg [3:0] counter;
  
  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;
  
  // Initialization
  initial begin
    state = IDLE;
    counter = 0;
    data_out = 0;
    valid = 0;
  end
  
  always @(posedge clk) begin
    case(state)
      IDLE: begin
        if (reset) begin
          counter <= 0;
          data_out <= 0;
          valid <= 0;
        end
        else begin
          counter <= counter + 1;
          data_out <= 0;
          if (counter == 4'b1010) begin
            state <= PROCESS;
          end
        end
      end
      WAIT: begin
        counter <= counter + 1;
        data_out <= 0;
        if (counter == 4'b1010) begin
          state <= PROCESS;
        end
      end
      PROCESS: begin
        data_out <= in;
        state <= DONE;
      end
      DONE: begin
        valid <= 1;
        state <= IDLE;
      end
    endcase
  end
  
endmodule
