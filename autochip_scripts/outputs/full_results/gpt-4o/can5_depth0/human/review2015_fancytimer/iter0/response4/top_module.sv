module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT1 = 3'b001,
        DETECT2 = 3'b010,
        DETECT3 = 3'b011,
        DETECT4 = 3'b100,
        LOAD_DELAY = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [15:0] count_down;
    reg [3:0] bit_counter;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0000;
            count_down <= 16'b0;
        end
        else begin
            state <= next_state;
            case (state)
                DETECT1: bit_counter <= bit_counter + 1'b1;
                DETECT2: bit_counter <= bit_counter + 1'b1;
                DETECT3: bit_counter <= bit_counter + 1'b1;
                LOAD_DELAY: delay <= {delay[2:0], data};
                COUNT: count_down <= count_down - 1'b1;
                DONE: count <= 4'bxxxx; // Don't care during DONE state
            endcase
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                counting = 1'b0;
                done = 1'b0;
                bit_counter = 4'b0000;
                if (data == 1 && bit_counter == 0)
                    next_state = DETECT1;
                else if (data == 0 && bit_counter == 4'd1)
                    next_state = IDLE;
            end
            DETECT1: begin
                if (data == 1 && bit_counter == 4'd1)
                    next_state = DETECT2;
                else
                    next_state = IDLE;
            end
            DETECT2: begin
                if (data == 0 && bit_counter == 4'd2)
                    next_state = DETECT3;
                else
                    next_state = IDLE;
            end
            DETECT3: begin
                if (data == 1 && bit_counter == 4'd3)
                    next_state = DETECT4;
                else
                    next_state = IDLE;
            end
            DETECT4: begin
                if (data == 0)
                    next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                if (bit_counter == 4'd4) begin
                    count_down = (delay + 1) * 1000;
                    count = delay;
                    counting = 1'b1;
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (count_down == 0) begin
                    counting = 1'b0;
                    done = 1'b1;
                    next_state = DONE;
                end
                else if (count_down % 1000 == 0)
                    count = count - 1;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end
endmodule
