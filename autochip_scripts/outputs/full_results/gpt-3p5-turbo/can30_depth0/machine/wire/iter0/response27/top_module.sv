module top_module(
  input wire clk,
  input wire reset,
  output wire data_out,
  output wire valid
);

  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      counter <= 8'b00000000;
      data <= 8'b00000000;
      valid <= 0;
    end else begin
      case (state)
        2'b00: begin // idle state
          counter <= 8'b00000000;
          data <= 8'b00000000;
          valid <= 0;
          if (in) begin // input signal used as a trigger to start FSM
            state <= 2'b01; // transition to wait state
          end
        end
        2'b01: begin // wait state
          counter <= counter + 1;
          data <= 8'b00000000;
          valid <= 0;
          if (counter >= 8'd10) begin // transition to process state after 10 clock cycles
            state <= 2'b10;
          end
        end
        2'b10: begin // process state
          data <= in; // set data output to input value
          valid <= 1; // set valid output to indicate data is valid
          state <= 2'b11; // transition to done state
        end
        2'b11: begin // done state
          data <= in; // keep data output the same
          valid <= 1; // keep valid output asserted
          state <= 2'b00; // transition back to idle state
        end
      endcase
    end
  end

  assign out = data_out;

endmodule
