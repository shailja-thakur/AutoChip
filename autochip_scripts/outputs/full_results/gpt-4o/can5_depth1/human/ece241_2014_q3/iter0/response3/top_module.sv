module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

always @(*) begin
    case ({c,d})
        2'b00: mux_in = 4'b0001;  // When cd = 00, mux_in = 0001
        2'b01: mux_in = 4'b1000;  // When cd = 01, mux_in = 1000
        2'b11: mux_in = 4'b1011;  // When cd = 11, mux_in = 1011
        2'b10: mux_in = 4'b1001;  // When cd = 10, mux_in = 1001
        default: mux_in = 4'b0000; // Default case
    endcase
end

endmodule
