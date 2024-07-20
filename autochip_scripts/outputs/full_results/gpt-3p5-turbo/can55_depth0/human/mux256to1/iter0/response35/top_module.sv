module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] sel_extended;
reg out;
reg [255:0] in_extended;

always @(*) begin
    case(sel)
        0: sel_extended = 8'b00000001;
        1: sel_extended = 8'b00000010;
        2: sel_extended = 8'b00000100;
        3: sel_extended = 8'b00001000;
        4: sel_extended = 8'b00010000;
        5: sel_extended = 8'b00100000;
        6: sel_extended = 8'b01000000;
        7: sel_extended = 8'b10000000;
        default: sel_extended = 8'b00000000;
    endcase
    
    in_extended = {256{sel_extended}};
    
    out = in_extended & in == in_extended;
    
end

endmodule
