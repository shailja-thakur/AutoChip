module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b10; // Reset to state B
        else begin
            case (state)
                2'b00: begin // State A, in = 0
                    if (in)
                        state <= 2'b01; // Transition to state A
                    else
                        state <= 2'b10; // Transition to state B
                end
                2'b01: begin // State A, in = 1
                    if (in)
                        state <= 2'b01; // Transition to state A
                    else
                        state <= 2'b00; // Transition to state B
                end
                2'b10: begin // State B, in = 0
                    if (in)
                        state <= 2'b00; // Transition to state A
                    else
                        state <= 2'b10; // Remain in state B
                end
                2'b11: begin // State B, in = 1
                    if (in)
                        state <= 2'b01; // Transition to state A
                    else
                        state <= 2'b10; // Remain in state B
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: out = 1'b0; // State A, in = 0
            2'b01: out = 1'b1; // State A, in = 1
            2'b10: out = 1'b1; // State B, in = 0
            2'b11: out = 1'b0; // State B, in = 1
        endcase
    end
    
endmodule
