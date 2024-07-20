module top_module (
    input wire a, 
    input wire b, 
    input wire c, 
    input wire d,
    output wire q
);
    // Logic for gate
    assign q = b | c;
    
endmodule
