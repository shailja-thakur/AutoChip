module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

  reg [1:0] state;
  wire [1:0] next_state;
  
  assign next_state = (reset) ? 2'b0 : (state == 2'b00 && j) ? 2'b01 :
                                        (state == 2'b01 && k) ? 2'b00 :
                                        (state == 2'b01 && !k) ? 2'b01 :
                                        state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else
      state <= next_state;
  end
  
  assign out = (state == 2'b01) ? 1'b1 : 1'b0;
  
endmodule
