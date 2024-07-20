module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);
  
  always @(posedge clk) begin
    case ({j, k})
      2'b00: Q <= Q;      // Maintain current state
      2'b01: Q <= 0;      // Reset state
      2'b10: Q <= 1;      // Set state
      2'b11: Q <= ~Q;     // Toggle state
    endcase
  end

endmodule
