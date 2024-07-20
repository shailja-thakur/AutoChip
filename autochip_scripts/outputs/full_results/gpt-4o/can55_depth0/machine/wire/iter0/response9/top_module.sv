module top_module(
  input clk,
  input reset,
  output reg data_out,
  output reg valid_out);
  
  // Internal signals
  reg [1:0] state;
  reg [7:0] counter;
  
  // State encoding
  parameter IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11;
  
  // FSM logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 8'b0;
      data_out <= 0;
      valid_out <= 0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 8'b0;
          data_out <= 0;
          valid_out <= 0;
          state <= WAIT;
        end
        
        WAIT: begin
          counter <= counter + 1;
          data_out <= 0;
          if (counter == 8'b11111111) begin
            state <= PROCESS;
          end
        end
        
        PROCESS: begin
          data_out <= /* Insert data processing logic here */;
          state <= DONE;
        end
        
        DONE: begin
          valid_out <= 1;
          state <= IDLE;
        end
        
        default: state <= IDLE;
      endcase
    end
  end
  
endmodule
