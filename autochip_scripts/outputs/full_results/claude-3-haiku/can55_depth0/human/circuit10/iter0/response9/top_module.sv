module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q_reg;
reg state_reg;

always @(posedge clk) begin
    case ({a, b})
        2'b00: begin
            q_reg <= q_reg;
            state_reg <= 1'b0;
        end
        2'b01: begin
            q_reg <= 1'b1;
            state_reg <= 1'b0;
        end
        2'b10: begin
            q_reg <= 1'b1;
            state_reg <= 1'b0;
        end
        2'b11: begin
            q_reg <= 1'b0;
            state_reg <= 1'b1;
        end
    endcase
end

assign q = q_reg;
assign state = state_reg;

endmodule
