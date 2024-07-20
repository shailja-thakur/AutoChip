module A(
    input x,
    input y,
    output z);
    
    assign z = (x ^ y) & x;
    
endmodule
module B(
    input x,
    input y,
    output z);
    
    reg prev_x = 0;
    reg prev_y = 0;
    always @(x, y) begin
        if (x != prev_x || y != prev_y) begin
            prev_x = x;
            prev_y = y;
            case({x, y})
                2'b00: z = 1;
                2'b01: z = 0;
                2'b10: z = 0;
                2'b11: z = 1;
            endcase
        end
    end
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    A A1(
        .x(x),
        .y(y),
        .z(wire_a));
        
    B B1(
        .x(x),
        .y(y),
        .z(wire_b));
        
    A A2(
        .x(x),
        .y(y),
        .z(wire_c));
        
    B B2(
        .x(x),
        .y(y),
        .z(wire_d));
        
    wire wire_a, wire_b, wire_c, wire_d;
    wire or_output, and_output;
    
    assign or_output = wire_a | wire_b;
    assign and_output = wire_c & wire_d;
    assign z = or_output ^ and_output;
    
endmodule
