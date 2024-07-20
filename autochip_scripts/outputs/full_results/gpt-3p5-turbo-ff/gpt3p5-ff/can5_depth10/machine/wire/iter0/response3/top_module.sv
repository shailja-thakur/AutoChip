module top_module(
  input wire clk,
  input wire reset,
  output wire data_out,
  output wire valid_out
);

  // Internal signals
  reg [1:0] state;
  reg [7:0] counter;
  wire [7:0] data;
  
  // FSM states
  localparam IDLE = 2'b00;
  localparam WAIT = 2'b01;
  localparam PROCESS = 2'b10;
  localparam DONE = 2'b11;
  
  // Reset state
  always @(posedge reset) begin
    state <= IDLE;
    counter <= 8'd0;
    data_out <= 8'd0;
    valid_out <= 1'b0;
  end
  
  // FSM logic
  always @(posedge clk) begin
    case(state)
      IDLE:
        begin
          if(reset)
            state <= IDLE;
          else
            state <= WAIT;
        end
      WAIT:
        begin
          counter <= counter + 1;
          data <= 8'd0;
          state <= (counter == 8'd10) ? PROCESS : WAIT;
        end
      PROCESS:
        begin
          data_out <= data;
          state <= DONE;
        end
      DONE:
        begin
          valid_out <= 1'b1;
          state <= IDLE;
        end
      default:
        state <= IDLE;
    endcase
  end

endmodule
