module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [3:0] {
        IDLE = 4'd0,
        START_BIT = 4'd1,
        BIT_0 = 4'd2,
        BIT_1 = 4'd3,
        BIT_2 = 4'd4,
        BIT_3 = 4'd5,
        BIT_4 = 4'd6,
        BIT_5 = 4'd7,
        BIT_6 = 4'd8,
        BIT_7 = 4'd9,
        STOP_BIT = 4'd10
    } state_t;
    state_t state, next_state;
    
    reg [7:0] shift_reg;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State machine logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = BIT_0;
            end
            BIT_0: next_state = BIT_1;
            BIT_1: next_state = BIT_2;
            BIT_2: next_state = BIT_3;
            BIT_3: next_state = BIT_4;
            BIT_4: next_state = BIT_5;
            BIT_5: next_state = BIT_6;
            BIT_6: next_state = BIT_7;
            BIT_7: next_state = STOP_BIT;
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = STOP_BIT; // Wait till we find a stop bit
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic and data collection
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_byte <= 8'b0;
            done <= 1'b0;
            shift_reg <= 8'b0;
        end else begin
            done <= 1'b0;
            case (state)
                BIT_0: shift_reg[0] <= in;
                BIT_1: shift_reg[1] <= in;
                BIT_2: shift_reg[2] <= in;
                BIT_3: shift_reg[3] <= in;
                BIT_4: shift_reg[4] <= in;
                BIT_5: shift_reg[5] <= in;
                BIT_6: shift_reg[6] <= in;
                BIT_7: shift_reg[7] <= in;
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                    end
                end
            endcase
        end
    end

endmodule
