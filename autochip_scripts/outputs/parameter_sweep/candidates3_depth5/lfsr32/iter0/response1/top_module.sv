module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] state_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'b1;
            state_reg <= 32'h1;
        end else begin
            q <= state_reg[0];
            state_reg <= {state_reg[30:0], state_reg[31]} ^ {state_reg[10], state_reg[20], state_reg[30], state_reg[31]};
        end
    end
    
endmodule
