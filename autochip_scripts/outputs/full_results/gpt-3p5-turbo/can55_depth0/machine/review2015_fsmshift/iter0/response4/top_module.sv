module top_module(
    input clk,      // Clock signal
    input reset,    // Reset signal
    output shift_ena // Shift enable signal
);

    reg [2:0] state; // 3 bit state register
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Reset to state B0
        end else begin
            case (state)
                3'b000: begin // State B0
                    state <= 3'b001; // Transition to state B1
                end
                3'b001: begin // State B1
                    state <= 3'b010; // Transition to state B2
                end
                3'b010: begin // State B2
                    state <= 3'b011; // Transition to state B3
                end
                3'b011: begin // State B3
                    state <= 3'b100; // Transition to state Done
                end
                default: begin // Done
                    state <= 3'b100; // Stay in state Done
                end
            endcase
        end
    end

    assign shift_ena = (state != 3'b100);

endmodule
