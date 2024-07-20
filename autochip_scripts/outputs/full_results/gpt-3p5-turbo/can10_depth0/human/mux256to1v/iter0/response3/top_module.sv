module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [255:0] in_indexed [0:63];
reg [255:0] in_selected;

integer i;
always @(in) begin
    for(i = 0; i < 64; i = i+1) begin
        in_indexed[i] = in[(i*256) +: 256];
    end
end

always @(sel, in_indexed) begin
    case(sel)
        0: in_selected = in_indexed[0];
        1: in_selected = in_indexed[1];
        2: in_selected = in_indexed[2];
        3: in_selected = in_indexed[3];
        4: in_selected = in_indexed[4];
        5: in_selected = in_indexed[5];
        6: in_selected = in_indexed[6];
        7: in_selected = in_indexed[7];
        // add more cases up to sel = 63
    endcase
end

assign out = in_selected;

endmodule
