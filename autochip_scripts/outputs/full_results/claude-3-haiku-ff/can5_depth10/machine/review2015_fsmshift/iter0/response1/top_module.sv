module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    // 3-bit state register
    reg [2:0] state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // State B0
        end else begin
            case (state)
                3'b000: state <= 3'b001; // B0 -> B1
                3'b001: state <= 3'b010; // B1 -> B2
                3'b010: state <= 3'b011; // B2 -> B3
                3'b011: state <= 3'b100; // B3 -> Done
                3'b100: state <= 3'b100; // Stay in Done state
                default: state <= 3'b100; // Anything else goes to Done state
            endcase
        end
    end

    // Determine shift_ena
    always @(*) begin
        case (state)
            3'b000, 3'b001, 3'b010, 3'b011: shift_ena = 1'b1; // B0, B1, B2, B3
            3'b100: shift_ena = 1'b0; // Done
            default: shift_ena = 1'b0; // Anything else, shift_ena is 0
        endcase
    end

endmodule
