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
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        SHIFT = 3'b001,
        COUNT = 3'b010,
        DONE = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;

    state_t state, next_state;

    // Pattern detection shift register
    reg [3:0] shift_reg;

    // Counters for shift enable duration
    reg [2:0] shift_counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0000;
            shift_counter <= 3'b000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            
            // Shift register for detecting pattern 1101
            shift_reg <= {shift_reg[2:0], data};

            // State machine actions
            case (state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (shift_reg == 4'b1101) next_state <= SHIFT;
                    else next_state <= IDLE;
                end

                SHIFT: begin
                    shift_ena <= 1'b1;
                    if (shift_counter == 3'b100) begin
                        shift_counter <= 3'b000;
                        next_state <= COUNT;
                    end else begin
                        shift_counter <= shift_counter + 1'b1;
                        next_state <= SHIFT;
                    end
                end

                COUNT: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    if (done_counting) next_state <= DONE;
                    else next_state <= COUNT;
                end

                DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) next_state <= IDLE;
                    else next_state <= WAIT_ACK;
                end
                
                WAIT_ACK: begin
                    if (ack) next_state <= IDLE;
                    else next_state <= WAIT_ACK;
                end
                
                default: next_state <= IDLE;
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            IDLE: next_state = (shift_reg == 4'b1101) ? SHIFT : IDLE;
            SHIFT: next_state = (shift_counter == 3'b100) ? COUNT : SHIFT;
            COUNT: next_state = done_counting ? DONE : COUNT;
            DONE: next_state = ack ? IDLE : WAIT_ACK;
            WAIT_ACK: next_state = ack ? IDLE : WAIT_ACK;
            default: next_state = IDLE;
        endcase
    end
endmodule
