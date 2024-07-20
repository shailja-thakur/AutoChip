module top_module(
  input clk,
  input reset,
  output reg data_output,
  output reg valid_output
);
 
  // internal signals
  reg [1:0] state;
  reg [7:0] counter;
 
  // FSM states
  localparam IDLE_STATE = 2'b00;
  localparam WAIT_STATE = 2'b01;
  localparam PROCESS_STATE = 2'b10;
  localparam DONE_STATE = 2'b11;
 
  // Initial state assignment
  initial begin
    state <= IDLE_STATE;
    counter <= 8'b0;
    data_output <= 1'b0;
    valid_output <= 1'b0;
  end
 
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE_STATE;
      counter <= 8'b0;
      data_output <= 1'b0;
      valid_output <= 1'b0;
    end else begin
      case(state)
        IDLE_STATE: begin
          counter <= 8'b0;
          data_output <= 1'b0;
          if (reset) begin
            state <= IDLE_STATE;
          end else begin
            state <= WAIT_STATE;
          end
        end
        WAIT_STATE: begin
          counter <= counter + 1'b1;
          data_output <= 1'b0;
          if (counter >= 8'd10) begin
            state <= PROCESS_STATE;
            counter <= 8'b0;
          end else begin
            state <= WAIT_STATE;
          end
        end
        PROCESS_STATE: begin
          data_output <= in;
          state <= DONE_STATE;
        end
        DONE_STATE: begin
          valid_output <= 1'b1;
          state <= IDLE_STATE;
        end
      endcase
    end
  end
endmodule
