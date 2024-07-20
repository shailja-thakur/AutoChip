module top_module (
    input [3:0] x,
    input [3:0] y,
    output reg [4:0] sum
);

// Internal wires
wire [3:0] carry;
wire [3:0] sum_temp;

// Full adder instantiation
genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin: full_adder_inst
        full_adder u1(
            .x(x[i]),
            .y(y[i]),
            .carry_in(carry[i]),
            .sum_out(sum_temp[i]),
            .carry_out(carry[i+1])
        );
    end
endgenerate

assign sum = {carry[4], sum_temp};

// Full adder definition
module full_adder (
    input x,
    input y,
    input carry_in,
    output sum_out,
    output carry_out
);
    assign {carry_out, sum_out} = x + y + carry_in;
endmodule
