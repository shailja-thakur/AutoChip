module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

reg [1:0] ab;

always @* begin
    case({c, d})
        2'b00: ab = 2'b00;
        2'b01: ab = 2'b01;
        2'b11: ab = 2'b11;
        2'b10: ab = 2'b10;
    endcase
end

assign mux_in[0] = (ab == 2'b00) ? 1'b1 : 1'b0;
assign mux_in[1] = (ab == 2'b01) ? 1'b1 : 1'b0;
assign mux_in[2] = (ab == 2'b11) ? 1'b1 : 1'b0;
assign mux_in[3] = (ab == 2'b10) ? 1'b1 : 1'b0;

endmodule
