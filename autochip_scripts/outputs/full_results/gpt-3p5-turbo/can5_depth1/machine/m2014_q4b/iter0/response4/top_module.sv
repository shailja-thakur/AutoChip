module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);
  
  // Create a flip-flop
  always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
      q <= 0; // Asynchronous reset
    end else begin
      q <= d; // Store the value of d on rising edge of clk
    end
  end
  
endmodule
