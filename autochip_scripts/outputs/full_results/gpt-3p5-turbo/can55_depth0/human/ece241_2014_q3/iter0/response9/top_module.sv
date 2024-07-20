module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [3:0] temp; // intermediate wire
wire a, b; // multiplexer selector inputs

// create a, b signals based on the values of c and d
assign a = c & d;
assign b = c | d;

// create the intermediate wire connections based on Karnaugh map

// mux_in[0]
assign temp[0] = (~a & ~b & ~c & d) | (a & ~b & ~c & ~d);

// mux_in[1]
assign temp[1] = (a & ~b & ~c & d) | (a & ~b & c & ~d) | (a & b & ~c & ~d);

// mux_in[2]
assign temp[2] = (a & b & ~c & d) | (a & b & c & ~d) | (a & b & c & d) | (~a & b & ~c & ~d);

// mux_in[3]
assign temp[3] = (a & b & ~c & d) | (a & b & c & d);

// Connect temp to mux_in
assign mux_in = temp;

endmodule
