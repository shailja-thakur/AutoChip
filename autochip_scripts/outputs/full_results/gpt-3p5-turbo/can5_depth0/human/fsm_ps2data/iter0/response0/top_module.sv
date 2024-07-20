module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

  reg [7:0] byte1;
  reg [7:0] byte2;
  reg [7:0] byte3;
  reg done_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      byte1 <= 8'b0;
      byte2 <= 8'b0;
      byte3 <= 8'b0;
      done_reg <= 1'b0;
    end else begin
      byte1 <= in;
      byte2 <= byte1;
      byte3 <= byte2;
      done_reg <= (byte3[3] == 1'b1);
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      out_bytes <= 24'b0;
    end else begin
      if (done_reg) begin
        out_bytes <= {byte1, byte2, byte3};
      end
    end
  end

  assign done = done_reg;

endmodule
