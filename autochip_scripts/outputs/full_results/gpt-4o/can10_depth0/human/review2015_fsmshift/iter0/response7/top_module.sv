module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    reg [2:0] count;

    // State encoding
    localparam IDLE = 3'b000,
               SHIFT_0 = 3'b001,
               SHIFT_1 = 3'b010,
               SHIFT_2 = 3'b011,
               SHIFT_3 = 3'b100;

    // State transition on clock and reset
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT_0;
            count <= 3'b000;
            shift_ena <= 1;
        end else begin
            state <= next_state;

            // Assert shift_ena for exactly 4 clock cycles
            if (count < 3'b100) begin
                count <= count + 1;
                shift_ena <= 1;
            end else begin
                shift_ena <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            SHIFT_0: next_state = SHIFT_1;
            SHIFT_1: next_state = SHIFT_2;
            SHIFT_2: next_state = SHIFT_3;
            SHIFT_3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
endmodule
