module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output reg z
);
    always @(*) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end
endmodule
module top_module(
    input x,
    input y,
    output z
);
    wire a1_out, a2_out;
    wire b1_out, b2_out;
    
    // Instantiate the A and B modules
    A A1 (.x(x), .y(y), .z(a1_out));
    A A2 (.x(x), .y(y), .z(a2_out));
    B B1 (.x(x), .y(y), .z(b1_out));
    B B2 (.x(x), .y(y), .z(b2_out));
    
    // Intermediate signals for OR and AND
    wire or_out;
    wire and_out;

    // OR gate operation
    assign or_out = a1_out | b1_out;
    // AND gate operation
    assign and_out = a2_out & b2_out;
    
    // XOR gate operation for the final output
    assign z = or_out ^ and_out;
endmodule
