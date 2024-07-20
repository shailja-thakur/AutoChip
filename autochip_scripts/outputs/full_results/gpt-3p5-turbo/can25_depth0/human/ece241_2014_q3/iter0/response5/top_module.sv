module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [3:0] temp;

// Generating temp variables

and(c, ~d, temp[0]);
and(~c, ~d, temp[1]);
and(c, ~d, ~c, ~d, temp[2]);
or(and(~c, ~d, c, d, temp[3]);


assign mux_in[0] = temp[0];
assign mux_in[1] = temp[1];
assign mux_in[2] = temp[2];
assign mux_in[3] = temp[3];

endmodule
