module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

always @(*) begin
    case({c,d})
        2'b00: mux_in = 1;
        2'b01: mux_in = 2;
        2'b11: mux_in = 10;
        2'b10: mux_in = 5;
    endcase
end

endmodule
