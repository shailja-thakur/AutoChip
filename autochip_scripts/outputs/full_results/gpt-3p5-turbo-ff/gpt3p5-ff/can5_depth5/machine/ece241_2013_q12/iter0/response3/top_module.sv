module top_module (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);
  reg [7:0] q;
  wire [2:0] address;
  wire [7:0] shift;
  
  // Register
  always @(posedge clk) begin
    if (enable) begin
      q <= q << 1;
      q[0] <= S;
    end
  end
  
  // Address generation
  assign address = {A, B, C};
  
  // Mux select
  always @(address) begin
    case(address)
      3'b000: Z <= q[0];
      3'b001: Z <= q[1];
      3'b010: Z <= q[2];
      3'b011: Z <= q[3];
      3'b100: Z <= q[4];
      3'b101: Z <= q[5];
      3'b110: Z <= q[6];
      3'b111: Z <= q[7];
      default: Z <= 0;
    endcase
  end
endmodule
