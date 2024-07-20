module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    reg [7:0] q_temp;

    always @(posedge clk or negedge areset) begin
        if (areset == 0)
            q_temp <= 8'b0;
        else
            q_temp <= d;
    end

    assign q = q_temp;

endmodule
