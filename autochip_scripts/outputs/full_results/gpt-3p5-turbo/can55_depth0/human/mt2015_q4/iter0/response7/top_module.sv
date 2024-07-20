module A(
    input x,
    input y,
    output z
    );
    assign z = (x ^ y) & x;
endmodule
module B(
    input x,
    input y,
    output z
    );
    reg prev_x;
    reg prev_y;
    reg prev_z;

    always @(x, y) begin
        if (x != prev_x || y != prev_y) begin
            prev_z = (x ^ y) & x;
        end
        z <= prev_z;
        
        prev_x <= x;
        prev_y <= y;
    end
endmodule
module top_module(
	input x,
	input y,
	output z
    );
    wire a1_out, a2_out, b1_out, b2_out;
    reg prev_a_out1, prev_a_out2, prev_b_out1, prev_b_out2;
    
    A a1(.x(x), .y(y), .z(a1_out));
    A a2(.x(x), .y(y), .z(a2_out));
    B b1(.x(x), .y(y), .z(b1_out));
    B b2(.x(x), .y(y), .z(b2_out));
    
    or u_or(.a(a1_out), .b(b1_out), .z(prev_a_out1));
    and u_and(.a(a2_out), .b(b2_out), .z(prev_a_out2));
    xor u_xor(.a(prev_a_out1), .b(prev_a_out2), .z(z));
    
    always @(x, y, prev_a_out1, prev_a_out2) begin
        if (x != prev_x || y != prev_y) begin
            prev_b_out1 = b1_out;
            prev_b_out2 = b2_out;
        end
        prev_x <= x;
        prev_y <= y;
    end
endmodule
