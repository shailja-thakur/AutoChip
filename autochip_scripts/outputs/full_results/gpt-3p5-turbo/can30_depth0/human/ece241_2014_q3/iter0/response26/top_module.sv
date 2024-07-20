module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Declare internal wires
wire a_wire, b_wire;

// Assign values to a and b based on c and d
assign a_wire = ~c & ~d;
assign b_wire = c | ~d;

// Connect a and b to the 4-to-1 multiplexer inputs
assign mux_in[0] = a_wire & b_wire;
assign mux_in[1] = a_wire & ~b_wire;
assign mux_in[2] = ~a_wire & b_wire;
assign mux_in[3] = ~a_wire & ~b_wire;

endmodule
