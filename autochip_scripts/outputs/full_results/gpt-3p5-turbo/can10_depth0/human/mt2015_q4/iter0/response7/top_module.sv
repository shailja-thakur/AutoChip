module A (
    input x,
    input y,
    output z
);
    assign z = (x^y) & x;
endmodule
module B (
    input x,
    input y,
    output z
);
    // Simulation waveform
    reg x_in;
    reg y_in;
    wire z_out;
    
    initial begin
        x_in = 0;
        y_in = 0;
        #0;
        
        x_in = 0;
        y_in = 0;
        #5;
        
        x_in = 0;
        y_in = 0;
        #10;
        
        x_in = 0;
        y_in = 0;
        #15;
        
        x_in = 0;
        y_in = 0;
        #20;
        
        x_in = 0;
        y_in = 1;
        #25;
        
        x_in = 1;
        y_in = 0;
        #30;
        
        x_in = 0;
        y_in = 1;
        #35;
        
        x_in = 0;
        y_in = 1;
        #40;
        
        x_in = 1;
        y_in = 1;
        #45;
        
        x_in = 1;
        y_in = 1;
        #50;
        
        x_in = 0;
        y_in = 0;
        #55;
        
        x_in = 0;
        y_in = 1;
        #60;
        
        x_in = 0;
        y_in = 1;
        #65;
        
        x_in = 1;
        y_in = 1;
        #70;
        
        x_in = 0;
        y_in = 1;
        #75;
        
        x_in = 0;
        y_in = 1;
        #80;
        
        x_in = 0;
        y_in = 1;
        #85;
        
        x_in = 1;
        y_in = 0;
        #90;
        
        #5;
        $finish;
    end
    
    always @(x_in, y_in)
        z = (x_in^y_in) & x_in;
        
    assign x = x_in;
    assign y = y_in;
    assign z = z_out;
endmodule
module top_module (
    input x,
    input y,
    output z
);

    A A1 (.x(x), .y(y), .z(z_A1));
    B B1 (.x(x), .y(y), .z(z_B1));
    A A2 (.x(x), .y(y), .z(z_A2));
    B B2 (.x(x), .y(y), .z(z_B2));
    
    wire output_OR;
    wire output_AND;
    
    xor U1 (.a(output_OR), .b(output_AND), .z(z));
    
    or U2 (.a(z_A1), .b(z_B1), .z(output_OR));
    and U3 (.a(z_A2), .b(z_B2), .z(output_AND));

endmodule
