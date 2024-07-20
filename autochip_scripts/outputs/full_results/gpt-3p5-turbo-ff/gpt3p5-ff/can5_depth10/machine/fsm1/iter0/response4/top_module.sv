module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;  // Reset to state B
        else if (state == 2'b00) begin  // State A
            if (in)
                state <= 2'b00;  // Stay in state A
            else
                state <= 2'b01;  // Transition to state B
        end else if (state == 2'b01) begin  // State B
            if (in)
                state <= 2'b01;  // Stay in state B
            else
                state <= 2'b00;  // Transition to state A
        end
    end

    always @(state) begin
        if (state == 2'b01)
            out_reg <= 1'b1;  // Set output high when in state B
        else
            out_reg <= 1'b0;  // Set output low for other states
    end

    assign out = out_reg;

endmodule
