module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state, next_state;
    reg [1:0] shift_counter;

    // State encoding
    localparam [2:0] 
        IDLE = 3'b000,
        SHIFT0 = 3'b001,
        SHIFT1 = 3'b010,
        SHIFT2 = 3'b011,
        SHIFT3 = 3'b100;

    // State Transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @* begin
        case (state)
            IDLE: next_state = reset ? SHIFT0 : IDLE;
            SHIFT0: next_state = SHIFT1;
            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            shift_counter <= 2'b00;
            shift_ena <= 1'b0;
        end else begin
            case (state)
                SHIFT0, SHIFT1, SHIFT2, SHIFT3: begin
                    shift_ena <= 1'b1;
                    shift_counter <= shift_counter + 1;
                end
                default: shift_ena <= 1'b0;
            endcase
        end
    end

endmodule
