module top_module(
  input wire clk,
  input wire reset,
  output wire data_output,
  output wire valid_output);
  
  reg [1:0] state;
  reg [7:0] counter;
  wire data;
  
  stimulus_gen stimulus_gen_inst(
    .clk(clk),
    .reset(reset),
    .data(data)
  );
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      counter <= 8'b0;
      data_output <= 1'b0;
      valid_output <= 1'b0;
    end else begin
      case (state)
        2'b00: begin // idle state
          state <= 2'b01;
          counter <= 8'b0;
          data_output <= 1'b0;
          valid_output <= 1'b0;
        end
        2'b01: begin // wait state
          if (counter == 8'b11) begin
            state <= 2'b10;
            counter <= 8'b0;
            data_output <= data;
            valid_output <= 1'b0;
          end else begin
            counter <= counter + 1;
            data_output <= 1'b0;
            valid_output <= 1'b0;
          end
        end
        2'b10: begin // process state
          state <= 2'b11;
          counter <= 8'b0;
          data_output <= data;
          valid_output <= 1'b1;
        end
        2'b11: begin // done state
          state <= 2'b00;
          counter <= 8'b0;
          data_output <= 1'b0;
          valid_output <= 1'b0;
        end
      endcase
    end
  end
  
endmodule
module stimulus_gen(
  input wire clk,
  input wire reset,
  output reg data);
  
  always @(posedge clk) begin
    if (reset) begin
      data <= 1'b0;
    end else begin
      data <= 1'b1;
    end
  end
  
endmodule
