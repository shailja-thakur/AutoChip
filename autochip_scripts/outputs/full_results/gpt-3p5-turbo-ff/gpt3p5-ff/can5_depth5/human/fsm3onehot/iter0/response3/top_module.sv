module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// State transition logic
always @(*) begin
    case(state)
        // State A
        4'b0001: begin
            if(in) begin
                next_state = 4'b0010; // Transition to state B if input is 1
            end else begin
                next_state = 4'b0001; // Stay in state A if input is 0
            end
        end
        // State B
        4'b0010: begin
            if(in) begin
                next_state = 4'b0010; // Stay in state B if input is 1
            end else begin
                next_state = 4'b0100; // Transition to state C if input is 0
            end
        end
        // State C
        4'b0100: begin
            if(in) begin
                next_state = 4'b0001; // Transition to state A if input is 1
            end else begin
                next_state = 4'b1000; // Transition to state D if input is 0
            end
        end
        // State D
        4'b1000: begin
            if(in) begin
                next_state = 4'b0100; // Transition to state C if input is 1
            end else begin
                next_state = 4'b0010; // Transition to state B if input is 0
            end
        end
    endcase
end

// Output logic
always @(state) begin
    case(state)
        // State A
        4'b0001: out = 1'b0;
        // State B
        4'b0010: out = 1'b0;
        // State C
        4'b0100: out = 1'b0;
        // State D
        4'b1000: out = 1'b1;
    endcase
end

endmodule
