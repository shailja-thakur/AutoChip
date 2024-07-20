module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [7:0] sel_upper;
wire [3:0] in_sel;

assign sel_upper = sel << 2;
assign in_sel = in[sel_upper +: 4];

always @(*) begin
    case (sel)
        0: in_sel = in[3:0];
        1: in_sel = in[7:4];
        2: in_sel = in[11:8];
        3: in_sel = in[15:12];
        4: in_sel = in[19:16];
        // ... continue for all possible values of sel
    endcase
end

assign out = in_sel;

endmodule
