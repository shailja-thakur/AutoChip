module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] sum1, sum2;

// Half adder
assign sum1 = {1'b0, in[0]} + {1'b0, in[1]};

// Full adder
assign sum2 = sum1 + {1'b0, in[2]};

// Final output
assign out = sum2;

endmodule
