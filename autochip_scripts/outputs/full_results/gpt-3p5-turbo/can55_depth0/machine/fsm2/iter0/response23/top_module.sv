module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state, next_state;

    always @(*) begin
        if (state == 2'b00) begin
            if (j == 1'b1)
                next_state = 2'b01; // Transition from state A to B
            else
                next_state = 2'b00; // Stay in state A
        end
        else begin
            if (k == 1'b1)
                next_state = 2'b00; // Transition from state B to A
            else
                next_state = 2'b01; // Stay in state B
        end
    end

    always @(posedge clk) begin
        if (areset == 1'b1)
            state <= 2'b00; // Reset to state A
        else
            state <= next_state;
    end

    assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
