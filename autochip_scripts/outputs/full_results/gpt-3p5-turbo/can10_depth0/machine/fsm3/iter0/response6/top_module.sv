module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // Reset to state A
        else
            state <= next_state;
    end

    always @* begin
        case (state)
            2'b00: begin // State A
                if (in)
                    next_state = 2'b01; // Move to state B if input is 1
                else
                    next_state = 2'b00; // Stay in state A if input is 0
            end
            2'b01: begin // State B
                if (in)
                    next_state = 2'b01; // Stay in state B if input is 1
                else
                    next_state = 2'b10; // Move to state C if input is 0
            end
            2'b10: begin // State C
                if (in)
                    next_state = 2'b11; // Move to state D if input is 1
                else
                    next_state = 2'b00; // Move to state A if input is 0
            end
            2'b11: begin // State D
                if (in)
                    next_state = 2'b01; // Move to state B if input is 1
                else
                    next_state = 2'b10; // Move to state C if input is 0
            end
        endcase
    end

    assign out = (state == 2'b11); // Output is set to 1 when in state D

endmodule
