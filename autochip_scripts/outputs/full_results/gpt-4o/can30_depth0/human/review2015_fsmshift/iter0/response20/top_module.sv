module top_module (
    input clk,
    input reset,
    output reg shift_ena
    );

    reg [2:0] state, next_state;
    reg [2:0] counter;

    localparam IDLE = 3'b000;
    localparam SHIFT1 = 3'b001;
    localparam SHIFT2 = 3'b010;
    localparam SHIFT3 = 3'b011;
    localparam SHIFT4 = 3'b100;
    localparam DONE = 3'b101;

    // State transition
    always @ (posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        case (state)
            IDLE: next_state = (reset) ? SHIFT1 : IDLE;
            SHIFT1: next_state = (reset) ? SHIFT1 : SHIFT2;
            SHIFT2: next_state = (reset) ? SHIFT1 : SHIFT3;
            SHIFT3: next_state = (reset) ? SHIFT1 : SHIFT4;
            SHIFT4: next_state = (reset) ? SHIFT1 : DONE;
            DONE: next_state = (reset) ? SHIFT1 : DONE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @ (posedge clk) begin
        if (reset)
            shift_ena <= 1'b0;
        else begin
            case (state)
                SHIFT1: shift_ena <= 1'b1;
                SHIFT2: shift_ena <= 1'b1;
                SHIFT3: shift_ena <= 1'b1;
                SHIFT4: shift_ena <= 1'b1;
                DONE: shift_ena <= 1'b0;
                default: shift_ena <= 1'b0;
            endcase
        end
    end

endmodule
