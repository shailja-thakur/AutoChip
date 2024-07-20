module top_module (
    input clk,
    input in,
    input areset,
    output out
);

  reg [1:0] state;
  reg out_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b01;  // reset state to B
    else begin
      case (state)
        2'b00: if (in) state <= 2'b00; else state <= 2'b01;  // A -> A if in is high, else A -> B
        2'b01: if (in) state <= 2'b01; else state <= 2'b00;  // B -> B if in is high, else B -> A
      endcase
    end
  end
  
  always @(state) begin
    out_reg = (state == 2'b01) ? 1'b1 : 1'b0;
  end
  
  assign out = out_reg;
  
endmodule
