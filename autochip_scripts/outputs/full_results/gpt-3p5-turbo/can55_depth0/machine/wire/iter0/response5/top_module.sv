module top_module(
    input in,
    output out,
    input wire clk,
    input wire reset,
    output reg [7:0] data_output,
    output reg valid_output);
  
  reg [1:0] state;
  reg [7:0] counter;
  
  // Assign initial values to the output and internal signals
  initial begin
    data_output = 8'd0;
    valid_output = 1'b0;
    state = 2'b00;
    counter = 8'd0;
  end
  
  // FSM logic implementation
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      // reset the FSM state and counter
      state <= 2'b00;
      counter <= 8'd0;
      data_output <= 8'd0;
      valid_output <= 1'b0;
    end else begin
      case(state)
        2'b00: begin // idle state
          counter <= 8'd0;
          data_output <= 8'd0;
          valid_output <= 1'b0;
          
          if(in) begin
            state <= 2'b01; // transition to wait state
          end
        end
        
        2'b01: begin // wait state
          counter <= counter + 1;
          data_output <= 8'd0;
          valid_output <= 1'b0;
          
          if(counter == 8'd10) begin // threshold reached
            state <= 2'b10; // transition to process state
          end
        end
        
        2'b10: begin // process state
          data_output <= in; // assign input to the data output
          state <= 2'b11; //transition to done state
        end
        
        2'b11: begin // done state
          valid_output <= 1'b1;
          
          if(counter == 8'd2) begin // reset after 2 cycles in done state
            state <= 2'b00; // transition back to idle state
          end
        end
      endcase
    end
  end
  
  assign out = data_output;
  
endmodule
