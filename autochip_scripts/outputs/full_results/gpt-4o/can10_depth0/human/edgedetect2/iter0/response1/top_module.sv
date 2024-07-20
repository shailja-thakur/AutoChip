module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] previous_in;

    always @(posedge clk) begin
        anyedge <= (in ^ previous_in) & in;  // anyedge is set to detect any transition from 0 to 1
        previous_in <= in; // Update the previous_in with the current in
    end

endmodule
