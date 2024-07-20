module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg state_reg;

always @(posedge clk) begin
    case ({a, b})
        2'b00: begin
            state_reg <= 1'b0;
            q <= state_reg;
        end
        2'b01: begin
            state_reg <= 1'b0;
            q <= state_reg;
        end
        2'b10: begin
            state_reg <= 1'b1;
            q <= state_reg;
        end
        2'b11: begin
            state_reg <= ~state_reg;
            q <= state_reg;
        end
    endcase

    state <= state_reg;
end

endmodule
