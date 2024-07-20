module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define mux inputs based on the Karnaugh map
    assign mux_in[0] = d & ~c;          // ab=00: k-map value is 1 if (c,d)=(10), (01), (11); equivalent to d & ~c
    assign mux_in[1] = 1'b0;            // ab=01: k-map value is always 0
    assign mux_in[2] = d | (~c & ~d);   // ab=11: k-map value is 1 if (c,d)=(00), (10), (11); equivalent to d | (~c & ~d)
    assign mux_in[3] = d | ~c;  	       // ab=10: k-map value is 1 if (c,d)=(00), (10), (11); equivalent to d | ~c

endmodule
