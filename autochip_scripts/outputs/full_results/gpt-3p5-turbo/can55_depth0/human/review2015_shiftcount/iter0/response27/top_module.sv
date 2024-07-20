module top_module(
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);

  reg q_temp; // Temporary register to hold shifted value

  always @(posedge clk) begin
    if (shift_ena) begin
      // Shift in data if shift_ena is enabled
      q_temp <= {q[2:0], data};
    end
    else if (count_ena) begin
      // Decrement q if count_ena is enabled
      q_temp <= q - 1;
    end
    else begin
      // No action if neither shift_ena nor count_ena are enabled
      q_temp <= q;
    end
  end

  always @(posedge clk) begin
    if (shift_ena || count_ena) begin
      q <= q_temp; // Update q with the shifted or decremented value
    end
  end

endmodule
