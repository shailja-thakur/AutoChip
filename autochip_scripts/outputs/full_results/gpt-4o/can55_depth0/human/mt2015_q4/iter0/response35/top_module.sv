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
    output z
);
    reg [5:0] i;
    reg z_out;
    initial begin
        i = 0;
        z_out = 1;
    end

    always @(posedge y or posedge x) begin
        i = i + 1;
        case (i)
            0: z_out <= 1;
            1: z_out <= 1;
            2: z_out <= 1;
            3: z_out <= 1;
            4: z_out <= 1;
            5: z_out <= 0;
            6: z_out <= 0;
            7: z_out <= 0;
            8: z_out <= 0;
            9: z_out <= 1;
            10: z_out <= 1;
            11: z_out <= 1;
            12: z_out <= 0;
            13: z_out <= 0;
            14: z_out <= 1;
            15: z_out <= 0;
            16: z_out <= 0;
            17: z_out <= 0;
            default: z_out <= 1;
        endcase
    end
    assign z = z_out;
endmodule
module top_module (
    input x,
    input y,
    output z
);
    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;

    A a1(.x(x), .y(y), .z(a1_out));
    A a2(.x(x), .y(y), .z(a2_out));
    B b1(.x(x), .y(y), .z(b1_out));
    B b2(.x(x), .y(y), .z(b2_out));

    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;
endmodule
