module top_module (
    input c,
    input d,
    output wire [3:0] mux_in
);

reg [3:0] mux_in_reg;

always @(*) begin
    case({c,d})
        2'b00: mux_in_reg = 4'b0001;
        2'b01: mux_in_reg = 4'b1000;
        2'b11: mux_in_reg = 4'b1011;
        2'b10: mux_in_reg = 4'b1001;
    endcase
end

assign mux_in = mux_in_reg;

endmodule
