module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg next_state;
reg out_reg;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: begin
            if (in)
                next_state = 2'b01; //Transition to state B
            else
                next_state = 2'b00; //Remain in state A
            out_reg = 1'b0; //Output is 0 in state A
        end
        2'b01: begin
            if (in)
                next_state = 2'b01; //Remain in state B
            else
                next_state = 2'b10; //Transition to state C
            out_reg = 1'b0; //Output is 0 in state B
        end
        2'b10: begin
            if (in)
                next_state = 2'b11; //Transition to state D
            else
                next_state = 2'b00; //Transition to state A
            out_reg = 1'b0; //Output is 0 in state C
        end
        2'b11: begin
            if (in)
                next_state = 2'b01; //Transition to state B
            else
                next_state = 2'b10; //Remain in state D
            out_reg = 1'b1; //Output is 1 in state D
        end
        default: begin
            next_state = 2'b00;
            out_reg = 1'b0;
        end
    endcase
end

always @(posedge clk) begin
    out <= out_reg;
end

endmodule
