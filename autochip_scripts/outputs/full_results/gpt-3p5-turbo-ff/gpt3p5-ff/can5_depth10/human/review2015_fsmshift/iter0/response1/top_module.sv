module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [1:0] state_reg;
    reg [2:0] count_reg;
    wire pattern_detected;

    parameter IDLE_STATE = 2'b00;
    parameter DETECT_STATE = 2'b01;
    parameter ENABLE_STATE = 2'b10;

    assign pattern_detected = (state_reg == DETECT_STATE);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= IDLE_STATE;
            count_reg <= 3'b0;
            shift_ena <= 0;
        end else begin
            case (state_reg)
                IDLE_STATE: begin
                    if (pattern_detected)
                        state_reg <= DETECT_STATE;
                    else
                        state_reg <= IDLE_STATE;
                end
                DETECT_STATE: begin
                    if (count_reg == 3'b111)
                        state_reg <= ENABLE_STATE;
                    else
                        state_reg <= DETECT_STATE;
                end
                ENABLE_STATE: begin
                    state_reg <= IDLE_STATE;
                end
                default: begin
                    state_reg <= IDLE_STATE;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset)
            count_reg <= 3'b0;
        else if (state_reg == DETECT_STATE)
            count_reg <= count_reg + 1;
        else
            count_reg <= 3'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_ena <= 0;
        else if (state_reg == ENABLE_STATE)
            shift_ena <= 1;
        else
            shift_ena <= 0;
    end

endmodule
