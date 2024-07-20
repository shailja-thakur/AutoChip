module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Declare internal wire signals
wire mux_in_bit0;
wire mux_in_bit1;
wire mux_in_bit2;
wire mux_in_bit3;

// Assign the outputs to the internal wire signals
assign mux_in[0] = mux_in_bit0;
assign mux_in[1] = mux_in_bit1;
assign mux_in[2] = mux_in_bit2;
assign mux_in[3] = mux_in_bit3;

// Assign the internal wire signals based on the input signals
assign mux_in_bit0 = c | d;
assign mux_in_bit1 = 1'b0;
assign mux_in_bit2 = ~d;
assign mux_in_bit3 = c & d;

endmodule
