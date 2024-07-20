module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    reg [2:0] state, next_state;
    reg [3:0] pattern;
    
    // State encoding
    localparam IDLE        = 3'b000,
               DETECT_1    = 3'b001,
               DETECT_11   = 3'b010,
               DETECT_110  = 3'b011,
               DETECT_1101 = 3'b100,
               SHIFT       = 3'b101,
               COUNT       = 3'b110,
               DONE        = 3'b111;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (~data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (pattern == 4'b1111)
                    next_state = COUNT;
            end
            COUNT: begin
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            pattern <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    pattern <= 0;
                end
                DETECT_1, DETECT_11, DETECT_110, DETECT_1101: begin
                    // No action needed
                end
                SHIFT: begin
                    shift_ena <= 1;
                    pattern <= pattern + 1;
                    if (pattern == 4'b1111) 
                        shift_ena <= 0;
                end
                COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                end
                DONE: begin
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end
endmodule
