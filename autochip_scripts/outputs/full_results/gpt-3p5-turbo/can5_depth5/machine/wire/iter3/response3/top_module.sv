module top_module(
  input wire in,
  output wire out,
  input wire clk,
  input wire reset);
  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data_output;
  reg valid_output;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      counter <= 8'd0;
      data_output <= 8'd0;
      valid_output <= 0;
    end else begin
      case (state)
        2'b00: begin
          counter <= 8'd0;
          data_output <= 8'd0;
          valid_output <= 0;
          if (in) begin
            state <= 2'b01;
          end
        end
        2'b01: begin
          counter <= counter + 8'd1;
          data_output <= 8'd0;
          valid_output <= 0;
          if (counter >= 8'd10) begin
            state <= 2'b10;
          end
        end
        2'b10: begin
          data_output <= in;
          valid_output <= 1;
          state <= 2'b11;
        end
        2'b11: begin
          valid_output <= 0;
          state <= 2'b00;
        end
      endcase
    end
  end

  assign out = valid_output ? data_output : 0;
endmodule
