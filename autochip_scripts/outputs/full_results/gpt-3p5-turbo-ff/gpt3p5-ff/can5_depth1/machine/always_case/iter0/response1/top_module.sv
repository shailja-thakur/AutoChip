module top_module (
  input [2:0] sel,
  input [3:0] data0,
  input [3:0] data1,
  input [3:0] data2,
  input [3:0] data3,
  input [3:0] data4,
  input [3:0] data5,
  output reg [3:0] out
);

  always @*
  begin
    case(sel)
      3'b000: out <= data0; // if sel is 000, output data0
      3'b001: out <= data1; // if sel is 001, output data1
      3'b010: out <= data2; // if sel is 010, output data2
      3'b011: out <= data3; // if sel is 011, output data3
      3'b100: out <= data4; // if sel is 100, output data4
      3'b101: out <= data5; // if sel is 101, output data5
      default: out <= 4'b0000; // for all other sel values, output 0
    endcase
  end

endmodule
