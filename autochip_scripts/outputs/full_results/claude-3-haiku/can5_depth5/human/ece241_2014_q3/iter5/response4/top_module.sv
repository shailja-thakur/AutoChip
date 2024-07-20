module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] sel;
assign sel = {c, d};

always @(*) begin
    case (sel)
        2'b00: mux_in = 4'b0001;
        2'b01: mux_in = 4'b1000;
        2'b11: mux_in = 4'b1101;
        2'b10: mux_in = 4'b1011;
        default: mux_in = 4'b0000;
    endcase
end

endmodule
