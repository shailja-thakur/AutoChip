module top_module (
    input a,
    input b,
    output q
);

always @(*) begin
    case ({a, b})
        2'b00: q = 0;
        2'b01: q = 0;
        2'b10: q = 0;
        2'b11: q = 1;
        default: q = 0;
    endcase
end

endmodule
