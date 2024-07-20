module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

// Temporary variables to store previous values of p and q
reg p_temp;
reg q_temp;

always @(posedge clock) begin
  // Use blocking assignments to update p and q
  if (a == 1'b1 && p_temp == 1'b1) begin
    p <= 1'b0;
    q <= 1'b0;
  end else if (a == 1'b1) begin
    p <= 1'b1;
    q <= 1'b0;
  end else if (p_temp == 1'b1) begin
    p <= 1'b1;
    q <= 1'b1;
  end else begin
    p <= 1'b0;
    q <= 1'b0;
  end
  
  // Update the temporary variables
  p_temp <= p;
  q_temp <= q;
end

endmodule
