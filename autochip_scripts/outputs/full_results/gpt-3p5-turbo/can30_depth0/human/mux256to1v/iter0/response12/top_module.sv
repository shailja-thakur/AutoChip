module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] in_sel;
reg [7:0] sel2;

assign in_sel[0] = in[3:0];
assign in_sel[1] = in[7:4];
assign in_sel[2] = in[11:8];
// ...

always @(*) begin
    case (sel)
        0: sel2 = 0;
        1: sel2 = 1;
        2: sel2 = 2;
        // ...
    endcase
end

assign out = in_sel[sel2];

endmodule
