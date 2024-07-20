module top_module(
  input clk,
  input reset,
  output reg data_output,
  output reg valid_output
);
  
  reg [1:0] state;
  reg [7:0] counter;
  
  // Define the states
  parameter IDLE = 0;
  parameter WAIT = 1;
  parameter PROCESS = 2;
  parameter DONE = 3;
  
  // Output assignment
  assign out = data_output;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      data_output <= 0;
      valid_output <= 0;
    end else begin
      case (state)
        IDLE:
          begin
            counter <= 0;
            data_output <= 0;
            valid_output <= 0;
        
            if (in) begin
              state <= WAIT;
            end
          end
          
        WAIT:
          begin
            counter <= counter + 1;
            data_output <= 0;
            valid_output <= 0;
            
            if (counter >= 100) begin // Threshold value for wait state
              state <= PROCESS;
            end
          end
          
        PROCESS:
          begin
            data_output <= in;
            valid_output <= 0;
            state <= DONE;
          end
          
        DONE:
          begin
            data_output <= in;
            valid_output <= 1;
            state <= IDLE;
          end
      endcase
    end
  end

endmodule
