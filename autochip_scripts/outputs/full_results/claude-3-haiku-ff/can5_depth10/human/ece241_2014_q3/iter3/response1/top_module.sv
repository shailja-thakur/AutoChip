module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire c_not, d_not;
    wire [1:0] temp;

    // Complement the inputs
    assign c_not = ~c;
    assign d_not = ~d;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign temp[0] = (c & d_not) | (c_not & d);
    assign temp[1] = (c & d) | (c_not & d_not);

    // Connect the 2-to-1 mux outputs to the 4-to-1 mux inputs
    assign mux_in[0] = c_not & d_not;
    assign mux_in[1] = temp[0];
    assign mux_in[2] = temp[1];
    assign mux_in[3] = c & d;

endmodule
