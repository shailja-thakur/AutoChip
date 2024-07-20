module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    reg [2:0] counter;

    // State encoding
    localparam IDLE = 3'b000,
               SHIFT1 = 3'b001,
               SHIFT2 = 3'b010,
               SHIFT3 = 3'b011,
               SHIFT4 = 3'b100,
               DONE = 3'b101;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= SHIFT1;
            counter <= 3'd4;
        end else begin
            state <= next_state;
            if (counter > 3'd0) begin
                counter <= counter - 1;
            end else begin
                counter <= 3'd0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            SHIFT1: next_state = (counter > 3'd0) ? SHIFT2 : DONE;
            SHIFT2: next_state = (counter > 3'd0) ? SHIFT3 : DONE;
            SHIFT3: next_state = (counter > 3'd0) ? SHIFT4 : DONE;
            SHIFT4: next_state = (counter > 3'd0) ? DONE : DONE;
            DONE: next_state = DONE;
            default: next_state = DONE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            SHIFT1, SHIFT2, SHIFT3, SHIFT4: shift_ena = 1'b1;
            DONE: shift_ena = 1'b0;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule
