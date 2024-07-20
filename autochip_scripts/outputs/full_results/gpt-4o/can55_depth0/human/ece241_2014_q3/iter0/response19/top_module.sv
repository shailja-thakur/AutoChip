module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);
    always @(*) begin
        case ({c, d})
            2'b00: mux_in = 4'b0001; // mux_in[0] = 1, mux_in[1] = 0, mux_in[2] = 0, mux_in[3] = 1
            2'b01: mux_in = 4'b1000; // mux_in[0] = 1, mux_in[1] = 0, mux_in[2] = 0, mux_in[3] = 0
            2'b11: mux_in = 4'b1011; // mux_in[0] = 1, mux_in[1] = 0, mux_in[2] = 1, mux_in[3] = 1
            2'b10: mux_in = 4'b1001; // mux_in[0] = 1, mux_in[1] = 0, mux_in[2] = 0, mux_in[3] = 1
            default: mux_in = 4'b0000;
        endcase
    end
endmodule
