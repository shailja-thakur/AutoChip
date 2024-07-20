module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] flip_flop_out;
    
    wire xor_in = x ^ flip_flop_out[0];
    wire and_in = ~flip_flop_out[0];
    wire or_in = ~flip_flop_out[0];
    
    d_flip_flop dff0(
        .clk(clk),
        .d(xor_in),
        .q(flip_flop_out[0])
    );
    
    d_flip_flop dff1(
        .clk(clk),
        .d(and_in),
        .q(flip_flop_out[1])
    );
    
    d_flip_flop dff2(
        .clk(clk),
        .d(or_in),
        .q(flip_flop_out[2])
    );
    
    xnor_gate xnor(
        .a(flip_flop_out[0]),
        .b(flip_flop_out[1]),
        .c(flip_flop_out[2]),
        .z(z)
    );
    
endmodule
module d_flip_flop (
    input clk,
    input d,
    output q
);
    
    reg q;
    
    always @(posedge clk)
        q <= d;
        
endmodule
module xnor_gate (
    input a,
    input b,
    input c,
    output z
);
    
    wire [2:0] inputs_xor;
    wire [2:0] inputs_and;
    wire [2:0] inputs_or;
    
    assign inputs_xor = {a, b, c};
    assign inputs_and = ~inputs_xor;
    assign inputs_or = ~inputs_xor;
    
    assign z = ~inputs_and[0] & ~inputs_or[0];  
    
endmodule
