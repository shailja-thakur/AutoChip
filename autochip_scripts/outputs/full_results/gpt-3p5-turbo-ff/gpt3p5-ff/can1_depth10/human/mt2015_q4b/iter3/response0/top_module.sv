module top_module(
    input x,
    input y,
    output z);

    // Declare intermediate signals
    wire x_delayed;
    wire y_delayed;
    wire z_delayed;
    
    // Parameter for delay values
    parameter delay_x_value = 25;
    parameter delay_y_value = 35;
    parameter delay_z_value = 55;
    
    // Instantiate the delay modules
    delay_module #(delay_x_value) delay_x(
        .in(x),
        .out(x_delayed)
    );
    
    delay_module #(delay_y_value) delay_y(
        .in(y),
        .out(y_delayed)
    );
    
    delay_module #(delay_z_value) delay_z(
        .in(z),
        .out(z_delayed)
    );
    
    // Logic for z
    assign #delay_z_value z = !x_delayed | (y_delayed & z_delayed);
    
endmodule
module delay_module #(
    parameter delay = 1
)(
    input in,
    output out
);
    
    reg [delay-1:0] buffer;
    
    always @(in) begin
        buffer <= {buffer[delay-2:0], in};
    end
    
    assign out = buffer[delay-1];
    
endmodule
