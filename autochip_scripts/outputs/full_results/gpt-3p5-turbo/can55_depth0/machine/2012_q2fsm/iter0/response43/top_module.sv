module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // initial state is A
    else
        state <= next_state; // update state based on next_state
end

always @* begin
    case (state)
        3'b000: begin // state A
            if (w == 1)
                next_state = 3'b001; // transition to state B
            else
                next_state = 3'b000; // stay in state A
        end

        3'b001: begin // state B
            if (w == 1)
                next_state = 3'b010; // transition to state C
            else
                next_state = 3'b010; // transition to state D
        end

        3'b010: begin // state C
            if (w == 1)
                next_state = 3'b100; // transition to state E
            else
                next_state = 3'b010; // stay in state C
        end

        3'b011: begin // state D
            if (w == 1)
                next_state = 3'b111; // transition to state F
            else
                next_state = 3'b000; // transition to state A
        end

        3'b100: begin // state E
            if (w == 1)
                next_state = 3'b100; // stay in state E
            else
                next_state = 3'b010; // transition to state D
        end

        3'b111: begin // state F
            if (w == 1)
                next_state = 3'b010; // transition to state C
            else
                next_state = 3'b010; // stay in state F
        end
    endcase
end

assign z = (state == 3'b100) || (state == 3'b111); // set z to 1 if state is E or F

endmodule
