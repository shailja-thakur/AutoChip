module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_d; // Register to hold the previous state of 'in'

    always @(posedge clk) begin
        in_d <= in; // Store the previous state of 'in'
    end
    
    always @(posedge clk) begin
        anyedge <= (in ^ in_d) & in; // Detect edges and set output bits
    end

endmodule
