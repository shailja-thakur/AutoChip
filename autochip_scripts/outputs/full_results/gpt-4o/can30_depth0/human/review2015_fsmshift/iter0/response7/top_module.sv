module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] shift_counter;
    reg state, next_state;

    localparam [0:0] IDLE = 1'b0,
                     ENABLE_SHIFT = 1'b1;

    // State transition on the clock signal
    always @(posedge clk) begin
        if (reset) begin
            state <= ENABLE_SHIFT;
            shift_counter <= 3'b000;
        end else begin
            state <= next_state;
            if (state == ENABLE_SHIFT) begin
                shift_counter <= shift_counter + 1'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = IDLE;
            ENABLE_SHIFT: next_state = (shift_counter == 3'b100) ? IDLE : ENABLE_SHIFT;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            IDLE: shift_ena = 1'b0;
            ENABLE_SHIFT: shift_ena = 1'b1;
        endcase
    end
endmodule
