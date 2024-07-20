module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire a, b;
wire [1:0] mux_out;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign a = ~c & d;
assign b = c & ~d;

assign mux_in[0] = 1;
assign mux_in[1] = a;
assign mux_in[2] = b | a;
assign mux_in[3] = b | c;

endmodule
