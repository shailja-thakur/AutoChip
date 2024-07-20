module top_module(
  input wire clk,
  input wire reset,
  input wire in,
  output reg out);
  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data_output;
  reg valid_output;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00; // idle state
      counter <= 8'd0;
      data_output <= 8'd0;
      valid_output <= 0;
    end else begin
      case (state)
        2'b00: begin // idle state
          counter <= 8'd0;
          data_output <= 8'd0;
          valid_output <= 0;
          if (in) begin
            state <= 2'b01; // wait state
          end
        end
        2'b01: begin // wait state
          counter <= counter + 8'd1;
          data_output <= 8'd0;
          valid_output <= 0;
          if (counter >= 8'd10) begin // adjust the threshold as needed
            state <= 2'b10; // process state
          end
        end
        2'b10: begin // process state
          data_output <= in;
          valid_output <= 0;
          state <= 2'b11; // done state
        end
        2'b11: begin // done state
          valid_output <= 1;
          state <= 2'b00; // idle state
        end
      endcase
    end
  end

  assign out = valid_output ? data_output : 0;
endmodule
