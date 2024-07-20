module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // Define states
    typedef enum reg [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        LOAD_DELAY,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    reg [3:0] delay;
    reg [15:0] counter;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for state transitions and output controls
    always @(*) begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                count = 4'd0;
                if (data == 1'b1) next_state = DETECT_1;
            end

            DETECT_1: begin
                count = 4'd0;
                if (data == 1'b1) next_state = DETECT_11;
                else next_state = IDLE;
            end

            DETECT_11: begin
                count = 4'd0;
                if (data == 1'b0) next_state = DETECT_110;
                else next_state = IDLE;
            end

            DETECT_110: begin
                count = 4'd0;
                if (data == 1'b1) next_state = DETECT_1101;
                else next_state = IDLE;
            end

            DETECT_1101: begin
                count = 4'd0;
                delay = 4'd0;
                next_state = LOAD_DELAY;
            end

            LOAD_DELAY: begin
                count = delay;
                delay = {delay[2:0], data};
                if (delay[3] !== 1'bx) next_state = COUNTING;
            end

            COUNTING: begin
                count = counter[11:8];
                counting = 1'b1;
                if (counter == 16'd0) next_state = DONE;
                else counter = counter - 1;
            end

            DONE: begin
                done = 1'b1;
                count = 4'd0;
                if (ack == 1'b1) next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Counter logic
    always @(posedge clk) begin
        if (current_state == LOAD_DELAY) begin
            counter <= (delay + 1) * 1000;
        end
    end

    always @(current_state) begin
        case (current_state)
            COUNTING: begin
                counting = 1'b1;
                if (counter == 16'd0) begin
                    done = 1'b1;
                    count = 4'd0;
                end
            end

            DONE: begin
                counting = 1'b0;
                done = 1'b1;
                count = 4'd0;
            end

            default: begin
                counting = 1'b0;
                done = 1'b0;
                count = 4'dx;
            end
        endcase
    end

endmodule
