module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state
);

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // State B0
        end else begin
            case (state)
                3'b000: // State B0
                    state <= 3'b001; // Transition to B1
                3'b001: // State B1
                    state <= 3'b010; // Transition to B2
                3'b010: // State B2
                    state <= 3'b011; // Transition to B3
                3'b011: // State B3
                    state <= 3'b100; // Transition to Done
                default: // Non-transition states (Done)
                    state <= 3'b100;
            endcase
        end
    end

    assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);

endmodule
