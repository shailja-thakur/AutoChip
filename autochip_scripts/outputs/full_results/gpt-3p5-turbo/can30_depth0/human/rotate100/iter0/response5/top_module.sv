module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);
  
  // Internal signals
  reg [99:0] shift_reg; // Shift register
  
  always @(posedge clk) begin
    if (load) begin
      shift_reg <= data; // Load shift register with data when load is active
    end else begin
      case (ena)
        2'b01: shift_reg <= {shift_reg[0], shift_reg[99:1]}; // Rotate right by one bit
        2'b10: shift_reg <= {shift_reg[1:99], shift_reg[0]}; // Rotate left by one bit
        default: shift_reg <= shift_reg; // Do not rotate
      endcase
    end
  end
  
  assign q = shift_reg; // Output the contents of the shift register
  
endmodule
