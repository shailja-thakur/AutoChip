module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // Define states for the state machine
    typedef enum reg [2:0] {
        IDLE,
        DETECT_PATTERN,
        LOAD_DELAY,
        COUNTING,
        DONE
    } state_t;

    reg [2:0] current_state, next_state;
    reg [3:0] shift_reg;
    reg [12:0] delay_counter; // Max delay is 15 * 1000 = 15000, needs 14 bits
    reg [3:0] delay_value;
    reg [3:0] remaining_count;

    // State machine
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'bxxxx;  // Initial value for count when not counting
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                count <= 4'bxxxx;
                counting <= 1'b0;
                done <= 1'b0;
                if (data == 1'b1 && reset == 0) next_state = DETECT_PATTERN;
            end
            
            DETECT_PATTERN: begin
                if (shift_reg == 4'b1101) next_state = LOAD_DELAY;
                else if (reset) next_state = IDLE;
            end
            
            LOAD_DELAY: begin
                if (delay_counter == 4'b0000) next_state = COUNTING;
                else if (reset) next_state = IDLE;
            end
            
            COUNTING: begin
                counting <= 1'b1;
                if (delay_counter == 13'd0) next_state = DONE;
                else if (reset) next_state = IDLE;
            end
            
            DONE: begin
                counting <= 1'b0;
                done <= 1'b1;
                if (ack) next_state = IDLE;
                else if (reset) next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Shift register to detect 1101 pattern
    always @(posedge clk) begin
        if (reset || current_state == IDLE) begin
            shift_reg <= 4'b0000;
        end
        else if (current_state == DETECT_PATTERN) begin
            shift_reg <= {shift_reg[2:0], data};
        end
    end

    // Load the delay value
    always @(posedge clk) begin
        if (reset || current_state == IDLE) begin
            delay_value <= 4'b0000;
        end
        else if (current_state == DETECT_PATTERN && shift_reg == 4'b1101) begin
            delay_value <= {shift_reg[3:0]};
        end
    end

    // Counting for delay cycles
    always @(posedge clk) begin
        if (reset) begin
            delay_counter <= 13'd0;
            remaining_count <= 4'd0;
        end
        else if (current_state == COUNTING) begin
            if (delay_counter == 13'd0) begin
                delay_counter <= (remaining_count << 3'd10) - 13'd1;
                if (remaining_count != 4'd0) begin
                    remaining_count <= remaining_count - 4'd1;
                end
            end
            else begin
                delay_counter <= delay_counter - 13'd1;
            end
        end
        else if (current_state == LOAD_DELAY) begin
            remaining_count <= delay_value;
            delay_counter <= (delay_value + 4'd1) << 3'd10;
        end
    end

    // Output current count
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'bxxxx;
        end
        else if (current_state != COUNTING) begin
            count <= 4'bxxxx;
        end
        else if (current_state == COUNTING) begin
            if (delay_counter[9:0] == 10'd0) begin
                count <= (remaining_count == 4'd0) ? 4'd0 : remaining_count - 1;
            end
        end
    end
    
endmodule
