module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        DETECT = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNT_DOWN = 3'b011,
        WAIT_ACK = 3'b100
    } state_type;
    
    state_type state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [3:0] counter;
    reg [9:0] cycle_count;
  
    // State Transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = DETECT;
                else
                    next_state = IDLE;
            end
            DETECT: begin
                if (shift_reg == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = DETECT;
            end
            LOAD_DELAY: begin
                next_state = COUNT_DOWN;
            end
            COUNT_DOWN: begin
                if (cycle_count == (1000 * (delay + 1)))
                    next_state = WAIT_ACK;
                else
                    next_state = COUNT_DOWN;
            end
            WAIT_ACK: begin
                if (ack)
                    next_state = DETECT;
                else
                    next_state = WAIT_ACK;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 0;
            delay <= 0;
            counter <= 0;
            cycle_count <= 0;
            counting <= 0;
            done <= 0;
            count <= 4'bxxxx;
        end
        else begin
            case (state)
                IDLE: begin
                    shift_reg <= 0;
                    counting <= 0;
                    done <= 0;
                    count <= 4'bxxxx;
                end
                DETECT: begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in the data bit
                end
                LOAD_DELAY: begin
                    delay <= {delay[2:0], data}; // Load the delay time
                    counter <= delay;
                    cycle_count <= 0;
                    counting <= 1;
                end
                COUNT_DOWN: begin
                    if (cycle_count < 1000) begin
                        cycle_count <= cycle_count + 1;
                    end
                    else begin
                        cycle_count <= 0;
                        counter <= counter - 1;
                    end
                    if (counter > 0) begin
                        count <= counter;
                    end
                    else begin
                        count <= 0;
                        counting <= 0;
                    end
                end
                WAIT_ACK: begin
                    done <= 1;
                end
            endcase
        end
    end
endmodule
