module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

  // Internal signal to hold the shifted data
  reg [99:0] shifted_data;

  always @(posedge clk) begin
    if (load) begin
      // Load data on rising edge of the clock when load is high
      q <= data;
    end else begin
      case (ena)
        2'b01: shifted_data <= {q[98:0], 1'b0}; // Shift left
        2'b10: shifted_data <= {1'b0, q[99:1]}; // Shift right
        default: shifted_data <= q; // No shift
      endcase
      q <= shifted_data;
    end
  end

endmodule
