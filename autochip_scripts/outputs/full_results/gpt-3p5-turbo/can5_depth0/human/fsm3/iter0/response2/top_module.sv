module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  
  reg [1:0] state;
  reg out_reg;
  reg out_next;
  
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= A;
    else
      state <= out_next;
  end
  
  always @(state, in) begin
    if (state == A) begin
      if (in)
        out_next = B;
      else
        out_next = A;
    end else if (state == B) begin
      if (in)
        out_next = B;
      else
        out_next = C;
    end else if (state == C) begin
      if (in)
        out_next = D;
      else
        out_next = A;
    end else if (state == D) begin
      if (in)
        out_next = B;
      else
        out_next = C;
    end
  end
  
  always @(state) begin
    if (state == D)
      out_reg = 1'b1;
    else
      out_reg = 1'b0;
  end
  
  assign out = out_reg;
  
endmodule
