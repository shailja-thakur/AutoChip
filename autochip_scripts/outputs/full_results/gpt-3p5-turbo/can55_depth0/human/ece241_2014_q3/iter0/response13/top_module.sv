module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
    
    wire ab_00, ab_01, ab_11, ab_10;
    wire mux_out;
    
    assign ab_00 = ~c & ~d;
    assign ab_01 = c & ~d;
    assign ab_11 = c & d;
    assign ab_10 = ~c & d;
    
    mux_2to1_0 mux_0 (.a(ab_00), .b(ab_01), .sel(a), .out(mux_in[0]));
    mux_2to1_1 mux_1 (.a(ab_01), .b(ab_10), .sel(a), .out(mux_in[1]));
    mux_2to1_2 mux_2 (.a(ab_10), .b(ab_11), .sel(a), .out(mux_in[2]));
    mux_2to1_3 mux_3 (.a(ab_11), .b(ab_00), .sel(a), .out(mux_in[3]));
    
    mux_4to1 mux (.a(mux_in[0]), .b(mux_in[1]), .c(mux_in[2]), .d(mux_in[3]), .sel(b), .out(mux_out));
    
endmodule
module mux_2to1_0 (
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? b : a;
endmodule
module mux_2to1_1 (
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? b : a;
endmodule
module mux_2to1_2 (
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? b : a;
endmodule
module mux_2to1_3 (
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? b : a;
endmodule
module mux_4to1 (
    input a,
    input b,
    input c,
    input d,
    input sel,
    output out
);
    assign out = sel[0] ? (sel[1] ? d : c) : (sel[1] ? b : a);
endmodule
