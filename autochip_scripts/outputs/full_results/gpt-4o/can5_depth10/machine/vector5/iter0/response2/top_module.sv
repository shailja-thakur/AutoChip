module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
    wire [4:0] vec1_a, vec1_b, vec1_c, vec1_d, vec1_e;
    wire [4:0] vec2_a, vec2_b, vec2_c, vec2_d, vec2_e;
    wire [24:0] vec1, vec2;
    
    assign vec1_a = {5{a}};
    assign vec1_b = {5{b}};
    assign vec1_c = {5{c}};
    assign vec1_d = {5{d}};
    assign vec1_e = {5{e}};
	
    assign vec2_a = {5{a}};
    assign vec2_b = {5{b}};
    assign vec2_c = {5{c}};
    assign vec2_d = {5{d}};
    assign vec2_e = {5{e}};

    assign vec1 = ~{vec1_a, vec1_b, vec1_c, vec1_d, vec1_e};
    assign vec2 = {vec2_a, vec2_b, vec2_c, vec2_d, vec2_e};
    
    assign out = vec1 ^ vec2;
endmodule
