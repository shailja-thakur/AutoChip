module top_module (
	input [255:0] in,
	input [7:0] sel,
	output reg out
);

always @* begin
    case(sel)
        0: out = in[0];
        1: out = in[1];
        2: out = in[2];
        3: out = in[3];
        // ...
        255: out = in[255];
    endcase
end

endmodule
