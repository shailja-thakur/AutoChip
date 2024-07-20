module top_module (
    input wire [31:0] in,
    output reg [31:0] out
);

always @(*) begin
    out[7:0]     = in[7:0];
    out[15:8]    = in[15:8];
    out[23:16]   = in[23:16];
    out[31:24]   = in[31:24];
end

endmodule
