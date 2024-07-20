module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
  parameter WIDTH = 4;
  reg [3:0] mux_output;
  
  always @* begin
      case (sel)
          0: mux_output = in[WIDTH-1:WIDTH*(sel+1)];
          1: mux_output = in[WIDTH*sel + WIDTH-1:WIDTH*sel];
          2: mux_output = in[WIDTH*sel + WIDTH-1:WIDTH*sel];
          3: mux_output = in[WIDTH*sel + WIDTH-1:WIDTH*sel];
          4: mux_output = in[WIDTH*sel + WIDTH-1:WIDTH*sel];
          5: mux_output = in[WIDTH*sel + WIDTH-1:WIDTH*sel];
          6: mux_output = in[WIDTH*sel + WIDTH-1:WIDTH*sel];
          7: mux_output = in[WIDTH*sel + WIDTH-1:WIDTH*sel];
          default: mux_output = 0;
      endcase
  end

  assign out = mux_output;

endmodule
