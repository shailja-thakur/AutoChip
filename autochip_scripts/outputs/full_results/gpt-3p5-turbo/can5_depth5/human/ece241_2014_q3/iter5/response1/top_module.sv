module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

always @* begin
    case({c, d})
        2'b00: mux_in = 4'b0001;
        2'b01: mux_in = 4'b1000;
        2'b11: mux_in = 4'b1011;
        2'b10: mux_in = 4'b0101;
        default: mux_in = 4'bxxxx;
    endcase
end

endmodule
