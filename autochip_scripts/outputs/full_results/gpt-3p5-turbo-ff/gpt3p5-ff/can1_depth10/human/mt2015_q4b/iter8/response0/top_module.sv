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
    
    always @(posedge clk) begin
        x_delayed <= #delay_x_value x;
    end
    
    always @(posedge clk) begin
        y_delayed <= #delay_y_value y;
    end
    
    always @(posedge clk) begin
        z_delayed <= #delay_z_value z;
    end
    
    // Logic for z
    always @(posedge clk) begin
        z <= #delay_z_value ~x_delayed | (y_delayed & z_delayed);
    end
    
endmodule
module delay_module(
    input wire in,
    output reg out,
    input wire delay);
    
    reg [delay-1:0] buffer;
    
    always @(posedge clk) begin
        buffer <= #1 {buffer[delay-2:0], in};
    end
    
    assign out = buffer[delay-1];
    
endmodule
