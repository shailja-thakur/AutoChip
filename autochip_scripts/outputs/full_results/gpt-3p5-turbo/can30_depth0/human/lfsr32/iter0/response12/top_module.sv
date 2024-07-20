module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg <= 32'h1;
        end else begin
            reg <= {reg[30:0], reg[31] ^ reg[21] ^ reg[1] ^ reg[0]};
        end
    end

    assign q = reg;

endmodule
