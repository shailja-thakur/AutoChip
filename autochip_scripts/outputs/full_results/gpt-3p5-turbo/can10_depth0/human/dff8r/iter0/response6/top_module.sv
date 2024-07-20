module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  reg [7:0] q_next; // Create a temporary register for next state of q

  always @(posedge clk) begin
    if (reset) begin // If reset is active high
      q_next <= 8'b0; // Set q_next to all zeros
    end else begin
      q_next <= d; // Set q_next to input d
    end
  end

  always @(posedge clk) begin
    if (reset) begin // If reset is active high
      q <= 8'b0; // Set q to all zeros
    end else begin
      q <= q_next; // Set q to q_next
    end
  end

endmodule
