module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State definitions
    typedef enum logic [2:0] {
        IDLE,
        DETECT_1,
        DETECT_2,
        DETECT_3,
        DETECT_4,
        READ_DELAY,
        COUNTING,
        DONE
    } state_t;

    state_t state, next_state;

    reg [3:0] delay;
    reg [9:0] count_down;
    reg [3:0] delay_reg;
    
    assign count = count_down[9:6];

    // State Machine
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b1)
                    next_state = DETECT_2;
                else
                    next_state = IDLE;
            end
            DETECT_2: begin
                if (data == 1'b0)
                    next_state = DETECT_3;
                else
                    next_state = IDLE;
            end
            DETECT_3: begin
                if (data == 1'b1)
                    next_state = DETECT_4;
                else
                    next_state = IDLE;
            end
            DETECT_4: begin
                if (data == 1'b1)
                    next_state = READ_DELAY;
                else
                    next_state = IDLE;
            end
            READ_DELAY: begin
                next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                if (count_down == 10'd0)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic and counters
    always_ff @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            count_down <= 10'd0;
            delay_reg <= 4'd0;
        end else begin
            case (state)
                IDLE: begin
                    delay <= 4'd0;
                    count_down <= 10'd0;
                    delay_reg <= 4'd0;
                end
                READ_DELAY: begin
                    delay <= {delay[2:0], data};
                    if (delay[3:0] == 4'b0000)
                        count_down <= 10'd999;
                    else
                        count_down <= (delay[3:0] + 1'b1) * 1000 - 1;
                    delay_reg <= delay;
                end
                COUNTING: begin
                    if (count_down != 0)
                        count_down <= count_down - 1;
                end
                DONE: begin
                    if (ack == 1'b1) begin
                        delay <= 4'd0;
                        count_down <= 10'd0;
                        delay_reg <= 4'd0;
                    end
                end
            endcase
        end
    end
endmodule
