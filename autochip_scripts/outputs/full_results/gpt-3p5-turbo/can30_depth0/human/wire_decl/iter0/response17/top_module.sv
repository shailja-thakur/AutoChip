module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

    wire intermediate_1;
    wire intermediate_2;

    andGate AND1(a, b, intermediate_1);
    andGate AND2(c, d, intermediate_2);
    orGate OR1(intermediate_1, intermediate_2, out);
    notGate NOT1(out, out_n);
    
    //Instantiate the AND gate module
    module andGate (
        input a,
        input b,
        output out
    );
        assign out = a & b;
    endmodule
module orGate (
        input a,
        input b,
        output out
    );
        assign out = a | b;
    endmodule
module notGate (
        input a,
        output out
    );
        assign out = ~a;
    endmodule
