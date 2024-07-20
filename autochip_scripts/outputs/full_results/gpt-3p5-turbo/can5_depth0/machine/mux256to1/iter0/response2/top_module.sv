module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

reg [7:0] sel_index;
wire  out;

always @(*) begin
    sel_index = sel;
    out = in[sel_index];
end

endmodule
