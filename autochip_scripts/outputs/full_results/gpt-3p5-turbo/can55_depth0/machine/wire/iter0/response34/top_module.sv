module top_module(
  input wire clk,
  input wire rst,
  output reg [7:0] data_output,
  output reg valid_output
);

  reg [7:0] counter;
  reg [1:0] state;

  parameter IDLE = 0, WAIT = 1, PROCESS = 2, DONE = 3;
 
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      counter <= 0;
      data_output <= 8'b0;
      valid_output <= 0;
    end
    else begin
      case(state)
        IDLE: begin
          counter <= 0;
          data_output <= 8'b0;
          valid_output <= 0;
          if (in) begin
            state <= WAIT;
          end
        end
        WAIT: begin
          counter <= counter + 1;
          data_output <= 8'b0;
          valid_output <= 0;
          if (counter >= 4) begin
            state <= PROCESS;
          end
        end
        PROCESS: begin
          data_output <= in;
          state <= DONE;
        end
        DONE: begin
          valid_output <= 1;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
