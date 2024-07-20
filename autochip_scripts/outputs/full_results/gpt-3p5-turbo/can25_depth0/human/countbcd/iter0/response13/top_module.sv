module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);
  
  // Define internal variables
  reg [3:0] q0, q1, q2, q3;
  
  // Output assignment
  assign q = {q3, q2, q1, q0};
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset all digits to zero
      q0 <= 0;
      q1 <= 0;
      q2 <= 0;
      q3 <= 0;
    end else begin
      // Increment digits based on enable signals
      q0 <= q0 + 1;
      if (ena[1]) begin
        q1 <= q1 + 1;
        if (ena[2]) begin
          q2 <= q2 + 1;
          if (ena[3]) begin
            q3 <= q3 + 1;
          end
        end
      end
    end
  end
  
endmodule
