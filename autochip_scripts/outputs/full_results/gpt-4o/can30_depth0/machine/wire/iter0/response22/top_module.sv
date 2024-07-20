module top_module(
  input clock,
  input reset,
  output reg [7:0] data_output,
  output reg valid_output
);

  // Internal signals
  reg [1:0] state, next_state;
  reg [3:0] counter;
  
  // State encoding
  parameter IDLE = 2'b00,
            WAIT = 2'b01,
            PROCESS = 2'b10,
            DONE = 2'b11;
  
  // State Register
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
    end else begin
      state <= next_state;
      if (state == WAIT)
        counter <= counter + 1;
      else
        counter <= 0;
    end
  end
  
  // Next State Logic
  always @(*) begin
    case (state)
      IDLE: begin
        data_output = 0;
        valid_output = 0;
        if (!reset)
          next_state = WAIT;
        else
          next_state = IDLE;
      end

      WAIT: begin
        data_output = 0;
        valid_output = 0;
        if (counter == 4'd10)  // Replace 10 with the desired threshold value
          next_state = PROCESS;
        else
          next_state = WAIT;
      end
      
      PROCESS: begin
        data_output = 8'hFF;  // Replace with the actual processed data
        valid_output = 0;
        next_state = DONE;
      end
      
      DONE: begin
        data_output = 8'hFF;  // Replace with the actual processed data
        valid_output = 1;
        next_state = IDLE;
      end
      
      default: begin
        data_output = 0;
        valid_output = 0;
        next_state = IDLE;
      end
    endcase
  end

endmodule
