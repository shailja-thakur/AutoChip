module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    wire [1:0] next_state;
    
    // Combinational logic block to determine the next state
    always @ (state, in) begin
        case (state)
            2'b00: // State A
                if (in) begin
                    next_state = 2'b01; // Transition to State B
                end else begin
                    next_state = 2'b00; // Stay in State A
                end
            2'b01: // State B
                if (in) begin
                    next_state = 2'b01; // Stay in State B
                end else begin
                    next_state = 2'b10; // Transition to State C
                end
            2'b10: // State C
                if (in) begin
                    next_state = 2'b11; // Transition to State D
                end else begin
                    next_state = 2'b00; // Transition to State A
                end
            2'b11: // State D
                if (in) begin
                    next_state = 2'b01; // Transition to State B
                end else begin
                    next_state = 2'b10; // Transition to State C
                end
            default:
                next_state = 2'b00; // Default to State A
        endcase
    end
    
    // Sequential logic block for updating the state
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Reset to State A
        end else begin
            state <= next_state; // Update the state
        end
    end
    
    // Output signal
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
