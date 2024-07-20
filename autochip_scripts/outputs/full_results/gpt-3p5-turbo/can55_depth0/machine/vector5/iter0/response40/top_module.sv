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

    assign a_vec = {5{~a}};
    assign b_vec = {5{~b}};
    assign c_vec = {5{~c}};
    assign d_vec = {5{~d}};
    assign e_vec = {5{~e}};

    assign out = a_vec ^ b_vec ^ c_vec ^ d_vec ^ e_vec;
  
endmodule
