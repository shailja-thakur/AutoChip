module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] shift_reg;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      shift_reg <= 4'b0;
    end else begin
      shift_reg[0] <= in;
      shift_reg[1] <= shift_reg[0];
      shift_reg[2] <= shift_reg[1];
      shift_reg[3] <= shift_reg[2];
    end
  end
  
  assign out = shift_reg[3];
  
endmodule
