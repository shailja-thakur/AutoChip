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

    reg [1:0] time;
    reg [31:0] x_values;
    reg [31:0] y_values;
    reg [31:0] z_values;
    
    initial begin
        time = 0;
        x_values = 32'b00000000000000000000000000000000;
        y_values = 32'b00000000000000000000000000000000;
        z_values = 32'b00000000000000000000000000000000;
        
        #25 x = 1;
        #5 x = 0;
        #5 x = 1;
        #10 x = 0;
        #5 x = 1;
        #5 x = 0;
    end
    
    always begin
        case(time)
            0: begin
                y = 0;
                z = 1;
            end
            5: begin
                y = 0;
                z = 1;
            end
            10: begin
                y = 0;
                z = 1;
            end
            15: begin
                y = 0;
                z = 1;
            end
            20: begin
                y = 0;
                z = 1;
            end
            25: begin
                y = 0;
                z = 0;
            end
            30: begin
                y = 0;
                z = 0;
            end
            35: begin
                y = 1;
                z = 0;
            end
            40: begin
                y = 1;
                z = 0;
            end
            45: begin
                y = 1;
                z = 1;
            end
            50: begin
                y = 1;
                z = 1;
            end
            55: begin
                y = 0;
                z = 1;
            end
            60: begin
                y = 1;
                z = 0;
            end
            65: begin
                y = 1;
                z = 0;
            end
            70: begin
                y = 1;
                z = 1;
            end
            75: begin
                y = 1;
                z = 0;
            end
            80: begin
                y = 1;
                z = 0;
            end
            85: begin
                y = 1;
                z = 0;
            end
            90: begin
                y = 0;
                z = 0;
            end
            default: begin
                y = 0;
                z = 0;
            end
        endcase
        
        time = time + 5;
        x_values = {x_values[29:0], x};
        y_values = {y_values[29:0], y};
        z_values = {z_values[29:0], z};
    end
    
endmodule
module top_module(
    input x,
    input y,
    output z
);

    wire a1_out, a2_out, b1_out, b2_out, or_out, and_out;
    
    A a1(.x(x), .y(y), .z(a1_out));
    A a2(.x(x), .y(y), .z(a2_out));
    B b1(.x(x), .y(y), .z(b1_out));
    B b2(.x(x), .y(y), .z(b2_out));
    
    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;
    
endmodule
