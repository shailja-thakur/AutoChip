module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

// Define the state machine transitions
always_comb begin
    case(state)
        2'b00:  // State A
            begin
                if(in) begin
                    next_state = 2'b01;  // Transition to State B
                end else begin
                    next_state = 2'b00;  // Remain in State A
                end
            end
        2'b01:  // State B
            begin
                if(in) begin
                    next_state = 2'b01;  // Remain in State B
                end else begin
                    next_state = 2'b10;  // Transition to State C
                end
            end
        2'b10:  // State C
            begin
                if(in) begin
                    next_state = 2'b11;  // Transition to State D
                end else begin
                    next_state = 2'b00;  // Transition to State A
                end
            end
        2'b11:  // State D
            begin
                if(in) begin
                    next_state = 2'b01;  // Transition to State B
                end else begin
                    next_state = 2'b10;  // Transition to State C
                end
            end
    endcase
end

// Assign 'out' signal when in State D
always_comb begin
    out = (state == 2'b11) ? 1'b1 : 1'b0;
end

endmodule
