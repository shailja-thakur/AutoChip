module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] temp;

  always @(posedge clk) begin
    if (load) begin
      temp <= data;
    end else begin
      temp[511] <= 0;
      temp[0] <= 0;

      // Compute the next state for each cell
      for (int i=1; i<511; i=i+1) begin
        case ({temp[i-1], temp[i], temp[i+1]})
          3'b111: q[i] <= 1;
          3'b110: q[i] <= 0;
          3'b101: q[i] <= 1;
          3'b100: q[i] <= 1;
          3'b011: q[i] <= 1;
          3'b010: q[i] <= 1;
          3'b001: q[i] <= 1;
          3'b000: q[i] <= 0;
        endcase
      end
      q[511] <= 0;
      q[0] <= 0;
      q <= temp;
    end
  end
endmodule
