module top_module(
  input clk,
  input reset,
  output reg data_out,
  output reg valid_out
);

  reg [1:0] state;
  reg [3:0] counter;

  // FSM states
  localparam IDLE = 2'b00;
  localparam WAIT = 2'b01;
  localparam PROCESS = 2'b10;
  localparam DONE = 2'b11;

  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= IDLE;
    else begin
      case (state)
        IDLE: begin
          counter <= 4'b0000;
          data_out <= 1'b0;
          valid_out <= 1'b0;
          
          if (in)
            state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          data_out <= 1'b0;
          valid_out <= 1'b0;
          
          if (counter == 4'b1111)
            state <= PROCESS;
        end
        PROCESS: begin
          data_out <= in;
          valid_out <= 1'b1;
          state <= DONE;
        end
        DONE: begin
          valid_out <= 1'b1;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
