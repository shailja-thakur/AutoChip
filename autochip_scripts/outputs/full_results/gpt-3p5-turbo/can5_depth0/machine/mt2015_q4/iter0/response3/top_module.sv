module top_module(
    input x,
    input y,
    output z);

    // Declare internal signals
    wire a1;
    wire a2;

    // Instantiate gates
    and_gate #(.N(2)) gate1(.in({x, y}), .out(a1));
    or_gate #(.N(2)) gate2(.in({y, x}), .out(a2));
    and_gate #(.N(2)) gate3(.in({a1, a2}), .out(z));
    
endmodule
module and_gate #(parameter N = 2)(
    input [N-1:0] in,
    output out);

    assign out = &in;
    
endmodule
module or_gate #(parameter N = 2)(
    input [N-1:0] in,
    output out);

    assign out = |in;
    
endmodule
