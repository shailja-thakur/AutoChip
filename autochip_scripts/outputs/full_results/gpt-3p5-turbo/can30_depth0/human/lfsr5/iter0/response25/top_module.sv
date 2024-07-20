module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] lfsr_reg;
    reg feedback;

    always @(posedge clk) begin
        if (reset)
            lfsr_reg <= 5'b1;
        else begin
            feedback = lfsr_reg[3] ^ lfsr_reg[4];
            lfsr_reg <= {feedback, lfsr_reg[4:1]};
        end
    end

    assign q = lfsr_reg;

endmodule
