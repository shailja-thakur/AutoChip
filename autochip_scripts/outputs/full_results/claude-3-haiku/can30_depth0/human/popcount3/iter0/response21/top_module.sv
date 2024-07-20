module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] temp1, temp2;

assign temp1 = {1'b0, in[2]} + {1'b0, in[1]};
assign temp2 = temp1 + {1'b0, in[0]};
assign out = temp2;

endmodule
