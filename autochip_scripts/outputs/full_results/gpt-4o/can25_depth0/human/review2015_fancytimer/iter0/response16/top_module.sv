module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State Encoding
    typedef enum reg [2:0] {
        S_IDLE = 3'd0,
        S_DETECT = 3'd1,
        S_LOAD_DELAY = 3'd2,
        S_COUNTDOWN = 3'd3,
        S_DONE = 3'd4
    } state_t;

    state_t state, next_state;

    // Internal registers
    reg [3:0] delay;
    reg [2:0] bit_count;
    reg [15:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (data == 1'b1) begin
                    next_state = S_DETECT;
                end
            end
            S_DETECT: begin
                if (data == 4'b1101) begin
                    next_state = S_LOAD_DELAY;
                end 
            end
            S_LOAD_DELAY: begin
                if (bit_count == 4) begin
                    next_state = S_COUNTDOWN;
                end 
            end
            S_COUNTDOWN: begin
                if (cycle_count == 0) begin
                    next_state = S_DONE;
                end 
            end
            S_DONE: begin
                if (ack) begin
                    next_state = S_IDLE;
                end 
            end
        endcase
    end

    // Sequential block to handle various states and registers
    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            bit_count <= 3'd0;
            cycle_count <= 16'd0;
            done <= 1'b0;
            counting <= 1'b0;
            count <= 4'd0;
        end else begin
            case (state)
                S_IDLE: begin
                    done <= 1'b0;
                end
                S_DETECT: begin
                    if (data == 4'b1101) begin
                        bit_count <= 3'd0;
                    end
                end
                S_LOAD_DELAY: begin
                    delay[3:0] <= {delay[2:0], data};
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'd3) begin
                        cycle_count <= (delay + 1) * 1000;
                        count <= delay;
                    end
                end
                S_COUNTDOWN: begin
                    counting <= 1'b1;
                    if (cycle_count > 0) begin
                        cycle_count <= cycle_count - 1;
                    end
                    if (cycle_count % 1000 == 0) begin
                        count <= count - 1;
                    end
                end
                S_DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        count <= 4'd0;
                    end
                end
            endcase
        end
    end

endmodule
