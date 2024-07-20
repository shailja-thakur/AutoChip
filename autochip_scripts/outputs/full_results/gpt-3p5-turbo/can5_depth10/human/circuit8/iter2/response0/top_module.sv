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

always @(a, p, q) begin
  // Check if the output p and q match the expected values at specific times
  if (a == 1'b0) begin
    if (p != 1'b0 || q != 1'b0)
      $display("Mismatch at time %t: Expected p=0, q=0, but got p=%b, q=%b", $time, p, q);
  end else if (a == 1'b1 && p_temp == 1'b1) begin
    if (p != 1'b0 || q != 1'b0)
      $display("Mismatch at time %t: Expected p=0, q=0, but got p=%b, q=%b", $time, p, q);
  end else if (a == 1'b1 && p_temp == 1'b0) begin
    if (p != 1'b1 || q != 1'b0)
      $display("Mismatch at time %t: Expected p=1, q=0, but got p=%b, q=%b", $time, p, q);
  end else if (a == 1'b1 && p_temp == 1'b1 && q_temp == 1'b1) begin
    if (p != 1'b1 || q != 1'b1)
      $display("Mismatch at time %t: Expected p=1, q=1, but got p=%b, q=%b", $time, p, q);
  end
end

endmodule
