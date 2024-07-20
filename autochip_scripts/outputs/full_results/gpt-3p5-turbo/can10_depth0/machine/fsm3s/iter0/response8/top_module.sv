module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  wire state_A, state_B, state_C, state_D;
  
  assign state_A = (state == 2'b00);
  assign state_B = (state == 2'b01);
  assign state_C = (state == 2'b10);
  assign state_D = (state == 2'b11);
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: if (in) state <= 2'b01; else state <= 2'b00;
        2'b01: if (in) state <= 2'b01; else state <= 2'b10;
        2'b10: if (in) state <= 2'b11; else state <= 2'b00;
        2'b11: if (in) state <= 2'b01; else state <= 2'b10;
      endcase
    end
  end

  assign out = state_D;
  
endmodule
