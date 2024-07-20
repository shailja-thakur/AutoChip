module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] prev_in; // Register to store the previous state of 'in'

    always @(posedge clk) begin
        anyedge <= (in ^ prev_in) & in; // Detect any edge and set output bit after a 0 to 1 transition
        prev_in <= in; // Update previous state
    end

endmodule
