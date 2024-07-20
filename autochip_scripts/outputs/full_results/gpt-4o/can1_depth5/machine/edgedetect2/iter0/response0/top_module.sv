module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last;

    always @(posedge clk) begin
        // Calculate anyedge by XOR-ing the current and previous values of in
        anyedge <= in ^ d_last;

        // Update d_last with the current value of in for next comparison
        d_last <= in;
    end

endmodule
