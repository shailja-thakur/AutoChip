module top_module(
    input wire clk,
    input wire x,
    input wire y,
    output reg z);

    // Declare intermediate signals
    reg x_delayed;
    reg y_delayed;
    reg z_delayed;
    
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
    always @(posedge clk) begin
        z <= ~x_delayed | (y_delayed & z_delayed);
    end
    
endmodule
module delay_module #(
    parameter delay = 1
)(
    input in,
    output reg out
);
    
    reg [delay-1:0] buffer;
    
    always @(posedge clk) begin
        buffer <= {buffer[delay-2:0], in};
    end
    
    assign out = buffer[delay-1];
    
endmodule
