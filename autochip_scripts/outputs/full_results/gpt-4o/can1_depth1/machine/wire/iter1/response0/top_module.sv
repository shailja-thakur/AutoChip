module top_module(
  input clk,
  input reset,
  output reg [7:0] data_out,
  output reg valid_out
);

  // State encoding
  typedef enum logic [1:0] {
    IDLE    = 2'b00,
    WAIT    = 2'b01,
    PROCESS = 2'b10,
    DONE    = 2'b11
  } state_t;
  
  state_t state, next_state;

  // Internal signals
  reg [7:0] counter;

  // Sequential logic to update state and counter
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state     <= IDLE;
      counter   <= 8'd0;
    end else begin
      state     <= next_state;
      if (state == WAIT) begin
        counter <= counter + 1;
      end else if (state == IDLE) begin
        counter <= 8'd0;
      end
    end
  end

  // Combinational logic for state transition and outputs
  always @(*) begin
    // Default assignments
    next_state = state;
    data_out = 8'd0;
    valid_out = 1'b0;

    case (state)
      IDLE: begin
        if (reset) begin
          next_state = WAIT;
        end
      end
      WAIT: begin
        if (counter >= 8'd10) begin // Assume threshold is 10 clock cycles
          next_state = PROCESS;
        end
      end
      PROCESS: begin
        data_out = 8'd42; // Example data
        next_state = DONE;
      end
      DONE: begin
        valid_out = 1'b1;
        next_state = IDLE;
      end
    endcase
  end
endmodule
