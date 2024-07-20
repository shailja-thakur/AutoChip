module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg [1:0] state;
  wire next_state;
  
  assign next_state = (state == 2'b00 && j) | (state == 2'b01 && k);
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;
    end else begin
      state <= next_state;
    end
  end
  
  always @* begin
    case(state)
      2'b00: out = 1'b0;
      2'b01: out = 1'b0;
      2'b10: out = 1'b1;
      2'b11: out = 1'b1;
      default: out = 1'b0;
    endcase
  end

endmodule
