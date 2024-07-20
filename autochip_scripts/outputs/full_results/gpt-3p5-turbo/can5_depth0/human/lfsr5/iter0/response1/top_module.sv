module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] lfsr_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            lfsr_reg <= 5'b1;
        else begin
            lfsr_reg <= {lfsr_reg[3] ^ lfsr_reg[2], lfsr_reg[4:1]};
        end
    end
    
    assign q = lfsr_reg;

endmodule
