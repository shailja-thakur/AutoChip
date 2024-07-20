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

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        S1101 = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    reg [2:0] state, next_state;
    reg [2:0] shift_count; // 3-bit counter for 4 cycles (000 to 011)

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: 
                if (data == 1'b1) 
                    next_state = S1;
                else 
                    next_state = IDLE; 
            S1: 
                if (data == 1'b1)
                    next_state = S11; 
                else 
                    next_state = IDLE; 
            S11: 
                if (data == 1'b0) 
                    next_state = S110; 
                else 
                    next_state = S1; 
            S110: 
                if (data == 1'b1) 
                    next_state = S1101; 
                else 
                    next_state = IDLE; 
            S1101: 
                next_state = SHIFT; 
            SHIFT: 
                if (shift_count == 3'd3)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            COUNT: 
                if (done_counting) 
                    next_state = DONE;
                else 
                    next_state = COUNT; 
            DONE: 
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE; 
            default: 
                next_state = IDLE;
        endcase
    end

    // Output and shift count logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_count <= 3'b000;
        end else begin
            case (state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    shift_count <= 3'b000;
                end
                S1, S11, S110, S1101: begin
                    shift_ena <= 1'b0;
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                    shift_count <= shift_count + 1;
                end
                COUNT: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                end
                DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
