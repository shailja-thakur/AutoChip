module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg state_reg;
    
    always @(posedge clk) begin
        case ({a, b})
            2'b00: begin
                state_reg <= 0;
                q <= 0;
            end
            2'b01: begin
                state_reg <= 1;
                q <= 1;
            end
            2'b10: begin
                state_reg <= 0;
                q <= 1;
            end
            2'b11: begin
                state_reg <= 0;
                q <= 0;
            end
        endcase
    end
    
    assign state = state_reg;

endmodule
