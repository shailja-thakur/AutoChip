module top_module(
    input clk,
    input reset,
    output shift_ena
);

    reg [2:0] state_reg;
    always @(posedge clk) begin
        if (reset)
            state_reg <= 3'b000;
        else if (state_reg == 3'b000)
            state_reg <= 3'b001;
        else if (state_reg == 3'b001)
            state_reg <= 3'b010;
        else if (state_reg == 3'b010)
            state_reg <= 3'b011;
        else if (state_reg == 3'b011)
            state_reg <= 3'b100;
        else
            state_reg <= 3'b100;
    end
    
    assign shift_ena = (state_reg == 3'b000 || state_reg == 3'b001 || state_reg == 3'b010 || state_reg == 3'b011) ? 1'b1 : 1'b0;
    
endmodule
