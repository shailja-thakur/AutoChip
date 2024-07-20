module top_module (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);

reg [7:0] Q;
wire [7:0] mux_output;

// Shift register
always @(posedge clk) begin
  if (enable) begin
    Q <= {Q[6:0], S};
  end
end

// Multiplexers
always @(*) begin
  case ({A, B, C})
    3'b000: mux_output = Q[7];
    3'b001: mux_output = Q[6];
    3'b010: mux_output = Q[5];
    3'b011: mux_output = Q[4];
    3'b100: mux_output = Q[3];
    3'b101: mux_output = Q[2];
    3'b110: mux_output = Q[1];
    3'b111: mux_output = Q[0];
  endcase
end

assign Z = mux_output;

endmodule
