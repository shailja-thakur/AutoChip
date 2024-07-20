module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  // Register for the LFSR
  reg [31:0] shift_register;
  
  reg [31:0] expected_output;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_register <= 32'h1;
    end else begin
      shift_register <= {shift_register[31:1], 
                        shift_register[31] ^ (shift_register[22] ^ shift_register[2] ^ shift_register[1])};
    end
  end
  
  always@(negedge clk) begin
    if(reset) begin
      expected_output <= 32'h1;
    end else begin
      expected_output <= {expected_output[31:1], 
                        expected_output[31] ^ (expected_output[22] ^ expected_output[2] ^ expected_output[1])};
    end
  end
  
  always @(negedge clk) begin
    if(q !== expected_output) begin
      $display("Error: mismatch at time %t", $time);
      $finish;
    end
  end
  
  assign q = shift_register;
  
endmodule
