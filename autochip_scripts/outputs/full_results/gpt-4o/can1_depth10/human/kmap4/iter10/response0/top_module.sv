module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        2'b00: out = b;
        2'b01: out = a;
        2'b10: out = b;
        2'b11: out = a;
        default: out = 1'b0;  // Just for safety, although theoretically unnecessary
    endcase
end

endmodule
