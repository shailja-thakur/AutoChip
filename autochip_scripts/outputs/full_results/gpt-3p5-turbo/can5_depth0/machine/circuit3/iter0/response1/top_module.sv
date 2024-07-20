module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Declare intermediate wires for OR operation
    wire ab_or;
    wire cd_or;

    // Declare intermediate wire for AND operation
    wire q_logic;

    // Assign intermediate wires
    assign ab_or = a | b;
    assign cd_or = c | d;
    assign q_logic = ab_or & cd_or;

    // Assign output
    assign q = q_logic;

endmodule
