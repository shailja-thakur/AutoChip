module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q);

  reg [63:0] reg_data;
  
  always @(posedge clk) begin
    if (load) begin
      reg_data <= data;
    end else if (ena) begin
      case (amount)
        2'b00: reg_data <= reg_data << 1;
        2'b01: reg_data <= reg_data << 8;
        2'b10: reg_data <= $signed(reg_data[0]) ? {32'b11111111, reg_data[63:32]} : reg_data >> 1;
        2'b11: reg_data <= $signed(reg_data[7]) ? {56'b11111111, reg_data[63:8]} : reg_data >> 8;
      endcase
    end
    q <= reg_data;
  end
  
endmodule
