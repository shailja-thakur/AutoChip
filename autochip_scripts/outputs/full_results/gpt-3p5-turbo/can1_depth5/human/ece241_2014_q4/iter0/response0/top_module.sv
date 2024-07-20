module top_module (
    input clk,
    input x,
    output z
);
    
    reg [2:0] d_reg;
    wire [2:0] d_out;
    
    always @(posedge clk) begin
        d_reg <= {d_out[1], d_out[0], x};
    end
    
    xor gate1 (d_reg[0], d_out[0], x);
    and gate2 (d_reg[1], ~d_out[1], x);
    or gate3 (d_reg[2], ~d_out[2], x);
    
    xnor gate4 (z, d_out[2], d_out[1], d_out[0]);
    
endmodule
module xor (
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule
module and (
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or (
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
module xnor (
    input a,
    input b,
    input c,
    output y
);
    assign y = ~(a ^ b ^ c);
endmodule
