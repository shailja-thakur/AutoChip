module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

reg [7:0] sel_extended;
wire [255:0] in_extended;

assign in_extended = {256{sel_extended}};
assign out = in_extended[sel];

always @(*) begin
    case (sel)
        8'b00000000: sel_extended = 8'b00000001;
        8'b00000001: sel_extended = 8'b00000010;
        8'b00000010: sel_extended = 8'b00000100;
        8'b00000011: sel_extended = 8'b00001000;
        8'b00000100: sel_extended = 8'b00010000;
        8'b00000101: sel_extended = 8'b00100000;
        8'b00000110: sel_extended = 8'b01000000;
        8'b00000111: sel_extended = 8'b10000000;
        default: sel_extended = 8'b00000000;
    endcase
end

endmodule
