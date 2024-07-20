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
    typedef enum logic [2:0] {
        SEARCH = 3'b000,
        LOAD_DELAY = 3'b001,
        COUNTING = 3'b010,
        WAIT_ACK = 3'b011
    } states_t;
    
    states_t state, next_state;
    
    // Internal signals
    reg [3:0] shift_reg;
    reg [9:0] countdown;
    reg [3:0] delay;
    reg [3:0] current_delay;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            countdown <= 10'b0;
            current_delay <= 4'b0000;
            counting <= 0;
            done <= 0;
            count <= 4'b0000;
        end else begin
            case (state)
                SEARCH: begin
                    done <= 0;
                    counting <= 0;
                    count <= 4'b0000;
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        next_state = LOAD_DELAY;
                    end else begin
                        next_state = SEARCH;
                    end
                end
                
                LOAD_DELAY: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b0000) begin
                        delay <= {shift_reg[3], shift_reg[2], shift_reg[1], shift_reg[0]};
                        next_state = COUNTING;
                    end else begin
                        next_state = LOAD_DELAY;
                    end
                end
                
                COUNTING: begin
                    counting <= 1;
                    if (countdown == 0) begin
                        if (current_delay == 0) begin
                            counting <= 0;
                            done <= 1;
                            next_state = WAIT_ACK;
                        end else begin
                            current_delay <= current_delay - 1;
                            countdown <= 1000;
                        end
                    end else begin
                        countdown <= countdown - 1;
                    end
                    count <= current_delay;
                end
                
                WAIT_ACK: begin
                    if (ack) begin
                        next_state = SEARCH;
                    end else begin
                        next_state = WAIT_ACK;
                    end
                end
                
                default: next_state = SEARCH;
            endcase
        end
    end

    always_comb begin
        case (state)
            SEARCH: next_state = (shift_reg == 4'b1101) ? LOAD_DELAY : SEARCH;
            LOAD_DELAY: next_state = (shift_reg == 4'b0000) ? COUNTING : LOAD_DELAY;
            COUNTING: next_state = (countdown == 0 && current_delay == 0) ? WAIT_ACK : COUNTING;
            WAIT_ACK: next_state = (ack) ? SEARCH : WAIT_ACK;
            default: next_state = SEARCH;
        endcase
    end
endmodule
