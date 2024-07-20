module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
    );

    // States of the FSM
    typedef enum reg [2:0] {
        IDLE,       // Searching for 1101 pattern
        DETECTED,   // Pattern detected, shifting in delay value
        COUNTING,   // Counting cycles based on delay
        DONE        // Counting finished, waiting for ack
    } state_t;

    reg [3:0] delay;
    reg [15:0] cycles_left;
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'd0;
            cycles_left <= 16'd0;
            count <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if ({delay[2:0], data} == 4'b1101) begin  // Detecting start pattern
                    next_state = DETECTED;
                end
            end
            DETECTED: begin
                if (delay != 4'b1111) begin  // Shift in delay value (4 bits)
                    next_state = DETECTED;
                end else begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                if (cycles_left == 16'd0) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'd0;
            cycles_left <= 16'd0;
            count <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (next_state)
                IDLE: begin
                    delay <= (delay << 1) | data;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                DETECTED: begin
                    if (delay != 4'b1111) begin
                        delay <= (delay << 1) | data;
                    end
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (cycles_left == 16'd0) begin
                        count <= delay;
                    end else if (cycles_left % 1000 == 999) begin
                        count <= count - 1;
                    end
                    cycles_left <= cycles_left - 1;
                end
                DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == COUNTING && cycles_left == 16'd0) begin
            cycles_left <= (delay + 1) * 1000;
            count <= delay;
        end
    end
endmodule
