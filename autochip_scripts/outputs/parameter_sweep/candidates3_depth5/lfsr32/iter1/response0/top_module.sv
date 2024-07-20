module top_module(
  input clk,
  input reset,
  output reg [31:0] q);
  
  // Register for the LFSR
  reg [31:0] shift_register;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_register <= 32'h1;
    end else begin
      shift_register <= {shift_register[31:1], 
                        shift_register[31] ^ (shift_register[22] ^ shift_register[2] ^ shift_register[1])};
    end
  end
  
  assign q = shift_register;
endmodule
