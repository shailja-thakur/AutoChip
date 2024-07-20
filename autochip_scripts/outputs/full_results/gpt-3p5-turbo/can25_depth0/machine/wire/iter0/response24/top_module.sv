module top_module(
  input wire clk,
  input wire rst,
  output wire data,
  output wire valid
);

  // Internal signals
  reg [1:0] state;
  reg [7:0] counter;

  // FSM states
  localparam IDLE = 2'b00;
  localparam WAIT = 2'b01;
  localparam PROCESS = 2'b10;
  localparam DONE = 2'b11;

  // Data output and valid output
  assign out = data;
  assign valid = (state == DONE);

  // Initial state and output assignments
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      counter <= 0;
      data <= 0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 0;
          data <= 0;
          if (in) begin
            state <= WAIT;
          end
        end
        WAIT: begin
          counter <= counter + 1;
          data <= 0;
          if (counter >= 10) begin
            state <= PROCESS;
          end
        end
        PROCESS: begin
          data <= in;
          state <= DONE;
        end
        DONE: begin
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
