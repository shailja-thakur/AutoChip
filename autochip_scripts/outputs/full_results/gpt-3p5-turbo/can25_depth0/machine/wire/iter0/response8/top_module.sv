module top_module(
  input wire clk,
  input wire reset,
  output wire data_out,
  output wire valid_out
);

  reg [1:0] state;
  reg [3:0] counter;
  reg [7:0] data_out_reg;
  wire clk_edge;

  assign clk_edge = clk & ~clk;

  always @(posedge clk_edge or posedge reset) begin
    if (reset) begin
      state <= 2'b00; // idle state
      counter <= 0;
      data_out_reg <= 0;
      valid_out <= 0;
    end else begin
      case (state)
        2'b00: // idle state
          begin
            counter <= 0;
            data_out_reg <= 0;
            valid_out <= 0;
            if (in) begin
              state <= 2'b01; // wait state
            end
          end
        2'b01: // wait state
          begin
            counter <= counter + 1;
            data_out_reg <= 0;
            valid_out <= 0;
            if (counter == 4'd9) begin // threshold value
              state <= 2'b10; // process state
            end
          end
        2'b10: // process state
          begin
            counter <= 0;
            data_out_reg <= in;
            valid_out <= 0;
            state <= 2'b11; // done state
          end
        2'b11: // done state
          begin
            counter <= 0;
            data_out_reg <= 0;
            valid_out <= 1;
            state <= 2'b00; // idle state
          end
      endcase
    end
  end

  assign data_out = data_out_reg;

endmodule
