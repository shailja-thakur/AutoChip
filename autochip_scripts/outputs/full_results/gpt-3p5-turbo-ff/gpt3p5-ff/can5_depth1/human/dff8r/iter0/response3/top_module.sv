module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Define the D flip-flop
    reg [7:0] q_reg;
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            q_reg <= 8'b0;
        else
            q_reg <= d;
    end

    // Connect flip-flop output to module output
    assign q = q_reg;

endmodule
