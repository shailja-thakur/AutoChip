module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;          // Store the input value from the previous cycle
        anyedge <= (in ^ prev_in); // XOR current and previous input to detect any edge
    end

endmodule
