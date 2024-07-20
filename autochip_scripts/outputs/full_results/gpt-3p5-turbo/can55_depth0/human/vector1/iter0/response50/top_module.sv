module top_module (
    input [15:0] in,
    output reg [7:0] out_hi,
    output reg [7:0] out_lo
);

    // Assign the upper byte to out_hi and the lower byte to out_lo
    always @(*) begin
        out_hi = in[15:8];
        out_lo = in[7:0];
    end

endmodule
