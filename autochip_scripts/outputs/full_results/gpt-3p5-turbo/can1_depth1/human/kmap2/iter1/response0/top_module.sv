module top_module (
    input wire a, 
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

// Define all the intermediate signals
wire w1, w2;

// Instantiate the logic gates
and_gate gate1 (.out(w1), .a(a), .b(b));
and_gate gate2 (.out(w2), .a(c), .b(d));
or_gate gate3 (.out(out), .a(w1), .b(w2));

endmodule
module and_gate (
    output reg out,
    input wire a,
    input wire b
);
always @(*) begin
    out = a & b;
end
endmodule
module or_gate (
    output reg out,
    input wire a,
    input wire b
);
always @(*) begin
    out = a | b;
end
endmodule
