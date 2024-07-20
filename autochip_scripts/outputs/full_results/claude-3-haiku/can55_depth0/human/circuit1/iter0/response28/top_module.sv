module top_module (
    input a,
    input b,
    output reg q
);

always @(*) begin
    case ({a, b})
        2'b00, 2'b01, 2'b10: q = 0;
        2'b11: q = 1;
        default: q = 0; // Not necessary, but good practice
    endcase
end

endmodule
