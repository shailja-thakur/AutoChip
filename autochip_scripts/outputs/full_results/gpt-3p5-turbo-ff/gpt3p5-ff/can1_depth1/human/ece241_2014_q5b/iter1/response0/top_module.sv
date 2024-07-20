module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset state A
    else
        state <= next_state;
end

always @* begin
    case (state)
        2'b00: begin // State A
            if (x)
                next_state = 2'b10; // Transition to state B if x=1
            else
                next_state = 2'b00; // Remain in state A if x=0

            z = 0; // Output z=0 in state A
        end

        2'b10: begin // State B
            if (!x)
                next_state = 2'b10; // Remain in state B if x=0
            else
                next_state = 2'b10; // Remain in state B if x=1

            z = 1; // Output z=1 in state B
        end
    endcase
end

endmodule
