module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

reg [255:0] mux_in;
reg [7:0] sel_in;
wire [7:0] sel_mod;

assign sel_mod = in[sel];

always @* begin
   for (int i = 0; i <= 255; i = i+1) begin
      mux_in[i] = in[i] & sel_mod[i];
   end
end

assign out = |mux_in;

endmodule
