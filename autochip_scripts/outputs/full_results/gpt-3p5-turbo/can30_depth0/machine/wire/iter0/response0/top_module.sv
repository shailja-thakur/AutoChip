module top_module(
  input wire clock,
  input wire reset,
  output wire data_output,
  output wire valid_output);

  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data;

  assign out = data_output;
  
  always @(posedge clock or posedge reset)
  begin
    if(reset)
    begin
      state <= 2'b00; // idle state
      counter <= 8'd0;
      data_output <= 8'd0;
    end
    else
    begin
      case(state)
        2'b00: //idle
        begin
          counter <= 8'd0;
          data_output <= 8'd0;
          
          if(in)
            state <= 2'b01; // wait state
        end
        2'b01: // wait
        begin
          counter <= counter + 1;
          data_output <= 8'd0;
          
          if(counter == 8'd10) // threshold
            state <= 2'b10; // process state
        end
        2'b10: // process
        begin
          data_output <= data; // data being processed
          state <= 2'b11; // done state
        end
        2'b11: // done
        begin
          valid_output <= 1'b1;
          state <= 2'b00; // idle state
        end
      endcase
    end
  end
endmodule
