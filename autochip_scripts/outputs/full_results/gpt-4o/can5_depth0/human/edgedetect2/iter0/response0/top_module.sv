module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_prev; // Register to store previous value of 'in'

    always @(posedge clk) begin
        in_prev <= in;             // Capture current 'in' value for next clock cycle comparison
        anyedge <= in ^ in_prev;   // Detect any change (edge) in 'in' and assign to 'anyedge'
    end

endmodule
