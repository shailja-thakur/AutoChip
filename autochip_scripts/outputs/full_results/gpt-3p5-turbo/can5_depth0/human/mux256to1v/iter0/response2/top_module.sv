module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [255:0] mux_input [0:255];

integer i;
always @(sel) begin
    for(i=0; i<256; i=i+1) begin
        mux_input[i] = in[(i*4)+:4];
    end
end

always @(sel) begin
    case(sel)
        0: out = mux_input[0];
        1: out = mux_input[1];
        2: out = mux_input[2];
        3: out = mux_input[3];
        // ... continue for all 256 cases ...
        default: out = 4'b0;
    endcase
end

endmodule
