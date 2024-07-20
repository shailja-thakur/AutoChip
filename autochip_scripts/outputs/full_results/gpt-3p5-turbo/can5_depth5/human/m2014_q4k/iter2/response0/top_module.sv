module top_module (
  input clk,
  input resetn,
  input in,
  output reg out
);

  reg [3:0] shift_register;
  wire [3:0] shifted_out;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      shift_register <= 4'b0;
    else begin
      shift_register <= {in, shift_register[3:1]};
    end
  end

  assign shifted_out = shift_register;
  
  always @(*) begin
    case (shift_register)
      4'b0000: out = 4'b0000;
      4'b0001: out = 4'b1000;
      4'b0010: out = 4'b0100;
      4'b0011: out = 4'b1100;
      4'b0100: out = 4'b0010;
      4'b0101: out = 4'b1010;
      4'b0110: out = 4'b0110;
      4'b0111: out = 4'b1110;
      4'b1000: out = 4'b0001;
      4'b1001: out = 4'b1001;
      4'b1010: out = 4'b0101;
      4'b1011: out = 4'b1101;
      4'b1100: out = 4'b0011;
      4'b1101: out = 4'b1011;
      4'b1110: out = 4'b0111;
      4'b1111: out = 4'b1111;
      default: out = 4'bxxxx;
    endcase
  end

endmodule
