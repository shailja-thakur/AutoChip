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
        IDLE = 3'b000,
        DETECT = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNT_DOWN = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;

    state_t state, next_state;

    // Internal signals
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [12:0] cycle_count;

    // FSM state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // FSM next state logic
    always_comb begin
        next_state = state; // Default stay in the same state
        case (state)
            IDLE: begin
                done = 0;
                counting = 0;
                if (data == 1'b1)
                    next_state = DETECT;
            end
            DETECT: begin
                if (shift_reg[3:0] == 4'b1101)
                    next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                next_state = COUNT_DOWN;
            end
            COUNT_DOWN: begin
                if (cycle_count == 0)
                    next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                done = 1;
                if (ack == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

    // Shift register and delay loading
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
        end else begin
            case (state)
                DETECT: begin
                    shift_reg <= (shift_reg << 1) | data;
                end
                LOAD_DELAY: begin
                    delay <= shift_reg;
                end
            endcase
        end 
    end

    // Cycle counter management
    always_ff @(posedge clk) begin
        if (reset) begin
            cycle_count <= 0;
            count <= 4'b1111; // Don't care value
        end else begin
            case (state)
                COUNT_DOWN: begin
                    counting <= 1;
                    if (cycle_count == 0) begin
                        if (count > 0) begin
                            count <= count - 1;
                            cycle_count <= 1000;
                        end else begin
                            counting <= 0;
                        end
                    end else begin
                        cycle_count <= cycle_count - 1;
                    end
                end
                default: begin
                    cycle_count <= delay * 1000 + 1000;
                    count <= delay;
                end
            endcase
        end
    end

endmodule
