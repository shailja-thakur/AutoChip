module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [255:0] mux_outs [0:3];

always @(*) begin
    case (sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        3: out = in[15:12];
        // ...
        default: out = 4'b0000;
    endcase
end

endmodule
