module top_module(
  input in,
  output out,
  input clk,
  input reset
);

  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data_out;
  reg valid_out;

  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else begin
      case(state)
        IDLE: begin
          counter <= 8'b0;
          data_out <= 8'b0;
          state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          data_out <= 8'b0;
          if (counter == 8'd9) // Change the threshold value to match the desired number of clock cycles
            state <= PROCESS;
        end
        PROCESS: begin
          data_out <= in;
          state <= DONE;
        end
        DONE: begin
          valid_out <= 1;
          state <= IDLE;
        end
      endcase
    end
  end

  assign out = valid_out ? data_out : 'bx; // Output 'data_out' only when 'valid_out' is asserted

endmodule
