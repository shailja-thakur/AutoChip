module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] a_vec;
    wire [4:0] b_vec;
    wire [4:0] c_vec;
    wire [4:0] d_vec;
    wire [4:0] e_vec;
    
    assign a_vec = a ? 0 : 5'b11111;
    assign b_vec = b ? 0 : 5'b11111;
    assign c_vec = c ? 0 : 5'b11111;
    assign d_vec = d ? 0 : 5'b11111;
    assign e_vec = e ? 0 : 5'b11111;
    
    assign out = ~(a_vec & b_vec & c_vec & d_vec & e_vec);

endmodule
