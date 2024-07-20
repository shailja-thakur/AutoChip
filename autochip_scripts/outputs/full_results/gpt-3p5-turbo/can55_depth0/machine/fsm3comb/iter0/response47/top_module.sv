module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    always_comb begin
        case(state)
            2'b00: // State A
                begin
                    if(in) begin
                        next_state = 2'b01; // Transition to state B
                    end else begin
                        next_state = 2'b00; // Remain in state A
                    end
                end
            2'b01: // State B
                begin
                    if(in) begin
                        next_state = 2'b01; // Remain in state B
                    end else begin
                        next_state = 2'b10; // Transition to state C
                    end
                end
            2'b10: // State C
                begin
                    if(in) begin
                        next_state = 2'b11; // Transition to state D
                    end else begin
                        next_state = 2'b00; // Transition to state A
                    end
                end
            2'b11: // State D
                begin
                    if(in) begin
                        next_state = 2'b01; // Transition to state B
                    end else begin
                        next_state = 2'b10; // Transition to state C
                    end
                end
        endcase
    end

    always @(posedge clk) begin
        out <= (state == 2'b11); // Set 'out' to high when in state D, low otherwise
    end
endmodule
