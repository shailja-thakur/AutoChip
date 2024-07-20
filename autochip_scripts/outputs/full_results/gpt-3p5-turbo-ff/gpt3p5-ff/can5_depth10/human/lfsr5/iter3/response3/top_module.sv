module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_reg;
    wire feedback;

    always @(posedge clk) begin
        if (reset)
            q_reg <= 1;
        else
            q_reg <= feedback ? {q_reg[3:0], q_reg[4] ^ q_reg[2]} : {q_reg[3:0], q_reg[4]};
    end

    assign feedback = q_reg[4] ^ q_reg[2];

    always @* begin
        q = q_reg;
    end

endmodule
