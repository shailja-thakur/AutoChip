module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [2:0] shift_enable_counter;

    // Define state codes
    parameter IDLE = 2'b00;
    parameter CHECK_PATTERN = 2'b01;
    parameter SHIFT_ENABLE = 2'b10;

    // Define bit pattern
    parameter PATTERN = 4'b1010;

    // Assign initial state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @* begin
        case (state)
            IDLE:
                begin
                    if (reset)
                        next_state = IDLE;
                    else
                        next_state = CHECK_PATTERN;
                end

            CHECK_PATTERN:
                begin
                    if (reset)
                        next_state = IDLE;
                    else if (PATTERN == 4'b1010)
                        next_state = SHIFT_ENABLE;
                    else
                        next_state = CHECK_PATTERN;
                end

            SHIFT_ENABLE:
                begin
                    if (reset)
                        next_state = IDLE;
                    else if (shift_enable_counter == 3)
                        next_state = IDLE;
                    else
                        next_state = SHIFT_ENABLE;
                end
        endcase
    end

    // Generate shift enable output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            shift_enable_counter <= 3'b0;
        end else begin
            case (state)
                SHIFT_ENABLE:
                    begin
                        shift_ena <= 1'b1;
                    end

                default:
                    begin
                        shift_ena <= 1'b0;
                    end
            endcase

            if (state == SHIFT_ENABLE) begin
                if (shift_enable_counter == 3)
                    shift_enable_counter <= 3'b0;
                else
                    shift_enable_counter <= shift_enable_counter + 1;
            end else begin
                shift_enable_counter <= 3'b0;
            end
        end
    end
endmodule
