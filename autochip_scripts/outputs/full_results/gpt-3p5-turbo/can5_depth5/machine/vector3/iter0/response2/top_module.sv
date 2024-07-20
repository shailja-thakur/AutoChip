module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

    wire [4:0] a_wire, b_wire, c_wire, d_wire, e_wire, f_wire;

    assign a_wire = a;
    assign b_wire = b;
    assign c_wire = c;
    assign d_wire = d;
    assign e_wire = e;
    assign f_wire = f;

    assign w = {a_wire, b_wire[3:0]};
    assign x = {c_wire, d_wire[3:0]};
    assign y = {e_wire, f_wire[3:0]};
    assign z = {2'b11, f_wire[3:0]};

endmodule
