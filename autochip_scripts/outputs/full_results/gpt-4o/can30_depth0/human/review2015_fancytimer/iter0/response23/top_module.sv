module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        PAT_DETECT = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNT = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [3:0] delay;
    reg [15:0] timer;
    reg [2:0] bit_count;
    reg [3:0] pattern_shift;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            pattern_shift <= 4'b0;
        end else if (current_state == PAT_DETECT) begin
            pattern_shift <= {pattern_shift[2:0], data};
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset || current_state != LOAD_DELAY) begin
            bit_count <= 3'b0;
        end else if (bit_count < 4) begin
            bit_count <= bit_count + 1;
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            delay <= 4'b0;
        end else if (current_state == LOAD_DELAY && bit_count < 4) begin
            delay <= {delay[2:0], data};
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            timer <= 16'b0;
        end else if (current_state == COUNT) begin
            if (timer == 16'd0) begin
                timer <= (delay + 16'd1) * 16'd1000;
            end else begin
                timer <= timer - 1;
            end
        end
    end
    
    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: begin
                counting <= 1'b0;
                done <= 1'b0;
            end
            PAT_DETECT: begin
            end
            LOAD_DELAY: begin
            end
            COUNT: begin
                counting <= 1'b1;
                if (timer > 1000) begin
                    count <= delay - timer[15:10] + 1;
                end else begin
                    count <= 4'b0;
                end
            end
            WAIT_ACK: begin
                done <= 1'b1;
                counting <= 1'b0;
            end
            default: begin
                done <= 1'b0;
                counting <= 1'b0;
            end
        endcase
    end
    
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = PAT_DETECT;
                end
            end
            PAT_DETECT: begin
                next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                if (bit_count == 4) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (timer == 0) begin
                    next_state = WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
