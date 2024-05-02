module top_module(
    input [254:0] in,
    output [7:0] out
);

    always @(in) begin
        out <= $countbits(in);
    end

endmodule