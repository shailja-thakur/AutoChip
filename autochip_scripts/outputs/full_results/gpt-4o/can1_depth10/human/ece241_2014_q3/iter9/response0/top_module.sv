module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

    always @(*) begin
        case ({c, d})
            2'b00: mux_in = 4'b0001; // cd = 00
            2'b01: mux_in = 4'b0000; // cd = 01
            2'b11: mux_in = 4'b1011; // cd = 11
            2'b10: mux_in = 4'b1001; // cd = 10
            default: mux_in = 4'b0000;
        endcase
    end

endmodule
