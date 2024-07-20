module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // reset to state B
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(state, in) begin
        case (state)
            2'b00: // State A
                if (in) begin
                    next_state = 2'b00; // Stay in state A
                end
                else begin
                    next_state = 2'b01; // Transition to state B
                end
            2'b01: // State B
                if (in) begin
                    next_state = 2'b01; // Stay in state B
                end
                else begin
                    next_state = 2'b00; // Transition to state A
                end
            default:
                next_state = 2'b01; // Default state B
        endcase
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
              
endmodule
