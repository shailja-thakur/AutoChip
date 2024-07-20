module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [1:0] ab;
wire [3:0] k_map;

// Implementing the 4-to-1 multiplexer
assign ab[0] = c;
assign ab[1] = d;

always @* begin
    case (ab)
        2'b00: k_map = 4'b1x10;
        2'b01: k_map = 4'b1000;
        2'b10: k_map = 4'b1001;
        2'b11: k_map = 4'b1101;
        default: k_map = 4'bxxxx;
    endcase
end

assign mux_in = k_map;

endmodule
