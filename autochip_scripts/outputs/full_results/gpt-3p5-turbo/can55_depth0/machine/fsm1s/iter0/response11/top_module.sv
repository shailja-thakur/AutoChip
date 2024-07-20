module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
  
  reg [1:0] state; // Parameterized register to store the current state of the state machine
  
  always @(posedge clk) begin // Always block triggered on the rising edge of the clk input
    if (reset) begin
      state <= 2'b1; // Initial state is B
    end else begin
      case (state)            
        2'b01: state <= (in ? 2'b01 : 2'b10); // If current state is A, next state is A if in is high, otherwise next state is B
        2'b10: state <= (in ? 2'b10 : 2'b01); // If current state is B, next state is B if in is high, otherwise next state is A
      endcase
    end
  end
  
  assign out = (state == 2'b10) ? 1'b1 : 1'b0; // If state is B, out is high, otherwise out is low
  
endmodule
