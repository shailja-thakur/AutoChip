module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;
    reg [4:0] q_reg;

    always @* begin
        q_next[4:1] = q_reg[3:0];
        q_next[0] = q_reg[4];
        q_next[2] = q_reg[2] ^ q_reg[0];
    end

    always @(posedge clk) begin
        if (reset) begin
            q_reg <= 5'b1;
        end else begin
            q_reg <= q_next;
        end
    end

    assign q = q_reg;

endmodule
