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
    IDLE,
    PATTERN_DETECT,
    DELAY_READ,
    COUNT,
    WAIT_ACK
} state_t;

state_t state, next_state;

// Internal registers and wires
reg [3:0] pattern_shift_reg;
reg [3:0] delay;
reg [12:0] cycle_count; // up to 8000, 13 bits
reg [3:0] current_count; // to store the current remaining time

// Sequential logic (state transition)
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Sequential logic (state action)
always @(posedge clk or posedge reset) begin
    if (reset) begin
        pattern_shift_reg <= 4'b0;
        delay <= 4'b0;
        cycle_count <= 13'b0;
        current_count <= 4'b0;
        counting <= 0;
        done <= 0;
        count <= 4'b0;
    end else begin
        case (state)
            IDLE: begin
                pattern_shift_reg <= 4'b0;
                delay <= 4'b0;
                cycle_count <= 13'b0;
                current_count <= 4'b0;
                counting <= 0;
                done <= 0;
                count <= 4'b0;
            end
            PATTERN_DETECT: begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end
            DELAY_READ: begin
                delay <= {delay[2:0], data};
            end
            COUNT: begin
                if (cycle_count == 13'd1) begin
                    if (current_count == 4'b0) begin
                        done <= 1;
                    end else begin
                        current_count <= current_count - 1;
                        cycle_count <= 13'd1000;
                    end
                end else begin
                    cycle_count <= cycle_count - 1;
                end
                count <= current_count;
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 0;
                end
            end
        endcase
    end
end

// Combinational logic (next state)
always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (pattern_shift_reg == 4'b1101) begin
                next_state = DELAY_READ;
            end else begin
                next_state = PATTERN_DETECT;
            end
        end
        PATTERN_DETECT: begin
            if (pattern_shift_reg == 4'b1101) begin
                next_state = DELAY_READ;
            end else begin
                next_state = PATTERN_DETECT;
            end
        end
        DELAY_READ: begin
            if (&delay) begin // If all 4 bits are read
                next_state = COUNT;
                current_count = delay;
                cycle_count = (delay + 1) * 13'd1000;
            end else begin
                next_state = DELAY_READ;
            end
        end
        COUNT: begin
            if (cycle_count == 13'd0 && current_count == 4'b0) begin
                next_state = WAIT_ACK;
            end else begin
                next_state = COUNT;
            end
        end
        WAIT_ACK: begin
            if (ack) begin
                next_state = IDLE;
            end else begin
                next_state = WAIT_ACK;
            end
        end
    endcase
end

endmodule
