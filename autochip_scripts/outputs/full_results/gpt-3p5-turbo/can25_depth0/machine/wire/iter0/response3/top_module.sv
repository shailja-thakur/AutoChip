module top_module(
  input wire clk,
  input wire reset,
  output wire data_out,
  output wire valid_out
);

  reg [1:0] state;
  reg [7:0] counter;
  wire clk_posedge;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;
      counter <= 8'b0;
      data_out <= 1'b0;
      valid_out <= 1'b0;
    end else begin
      case (state)
        2'b00: begin // idle state
          counter <= 8'b0;
          data_out <= 1'b0;
          valid_out <= 1'b0;
          if (in) begin
            state <= 2'b01;
          end
        end
        2'b01: begin // wait state
          counter <= counter + 8'b1;
          data_out <= 1'b0;
          valid_out <= 1'b0;
          if (counter >= 8'd10) begin // transition to process state
            state <= 2'b10;
          end
        end
        2'b10: begin // process state
          data_out <= in;
          valid_out <= 1'b1;
          state <= 2'b11; // transition to done state
        end
        2'b11: begin // done state
          valid_out <= 1'b1;
          state <= 2'b00; // transition back to idle state
        end
      endcase
    end
  end

endmodule
