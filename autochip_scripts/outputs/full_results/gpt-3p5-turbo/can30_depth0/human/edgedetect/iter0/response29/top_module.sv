module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
  
  reg [7:0] pedge_reg; // Register to store the output values
  
  always @(posedge clk) begin
    pedge_reg <= in; // Store the input values in the register on every clock cycle
    
    // Check for positive edge transition for each bit in the input vector
    for (int i = 0; i < 8; i = i + 1) begin
      if (pedge_reg[i] == 0 && in[i] == 1) begin
        pedge[i] <= 1; // Set the output bit to 1 on the next clock cycle after a 0 to 1 transition
      end else begin
        pedge[i] <= 0; // Set the output bit to 0 if no positive edge transition occurs
      end
    end
  end
endmodule
