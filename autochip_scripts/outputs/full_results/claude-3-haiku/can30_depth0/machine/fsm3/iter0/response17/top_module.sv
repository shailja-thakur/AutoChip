module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            2'b00: next_state = (in) ? 2'b01 : 2'b00; // State A
            2'b01: next_state = (in) ? 2'b01 : 2'b10; // State B
            2'b10: next_state = (in) ? 2'b11 : 2'b00; // State C
            2'b11: next_state = (in) ? 2'b01 : 2'b10; // State D
            default: next_state = 2'b00; // Default to State A
        endcase
    end
    
    // Output logic
    always @(*) begin
        out = (state == 2'b11); // Set out to 1 when in state D
    end

endmodule
