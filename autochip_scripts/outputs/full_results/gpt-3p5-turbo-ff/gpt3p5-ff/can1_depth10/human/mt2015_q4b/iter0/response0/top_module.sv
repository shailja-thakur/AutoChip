module top_module(
    input x,
    input y,
    output z);
    
    // Declare intermediate signals
    wire x_delayed;
    wire y_delayed;
    wire z_delayed;
    
    // Instantiate the delay modules
    delay_module delay_x(
        .in(x),
        .out(x_delayed),
        .delay(25)  // Delay x by 25 ns
    );
    
    delay_module delay_y(
        .in(y),
        .out(y_delayed),
        .delay(35)  // Delay y by 35 ns
    );
    
    delay_module delay_z(
        .in(z),
        .out(z_delayed),
        .delay(55)  // Delay z by 55 ns
    );
    
    // Logic for z
    assign z = ~x_delayed | (y_delayed & z_delayed);
    
endmodule
module delay_module(
    input in,
    output out,
    input delay);
    
    reg [delay-1:0] buffer;
    
    always @(in) begin
        buffer <= {buffer[delay-2:0], in};
    end
    
    assign out = buffer[delay-1];
    
endmodule
