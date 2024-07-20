module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter S0 = 1'b0, S1 = 1'b1;
reg state, next_state;
reg[7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        complement <= 8'd0;
    end
    else begin
        state <= next_state;
        complement <= (state == S0) ? {complement[6:0], x} : {1'b1, complement[7:1]};
    end
end

always @(*) begin
    case (state)
        S0: begin
            z = x;
            next_state = (x) ? S1 : S0;
        end
        S1: begin
            z = ~complement[0];
            next_state = (complement == 8'b11111111) ? S0 : S1;
        end
    endcase
end

endmodule
