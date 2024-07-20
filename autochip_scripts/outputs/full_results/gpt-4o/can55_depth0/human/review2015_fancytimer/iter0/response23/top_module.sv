module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE,
        SHIFT_PATTERN,
        SHIFT_DELAY,
        COUNTING,
        DONE
    } state_t;
    
    state_t current_state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [13:0] counter;  // Counting up to 14000 cycles, so we need 14 bits (2^14 = 16384)
    reg [13:0] limit;    // The total count limit
    
    // Output the remaining time
    assign count = (current_state == COUNTING) ? (counter / 1000) : 4'bz;

    // State transitions
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (shift_reg == 4'b1101)
                    next_state = SHIFT_DELAY;
            end
            
            SHIFT_DELAY: begin
                if (delay == 4'h0)
                    next_state = COUNTING;
            end
            
            COUNTING: begin
                if (counter == limit)
                    next_state = DONE;
            end
            
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Shift register and counter logic
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
            delay <= 4'b0;
            counter <= 14'b0;
            limit <= 14'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    shift_reg <= {shift_reg[2:0], data};
                    done <= 1'b0;
                end
                
                SHIFT_DELAY: begin
                    if (shift_reg == 4'b1101) begin
                        shift_reg <= {shift_reg[2:0], data};
                        delay <= {delay[2:0], data};
                        if (delay[3] == 1) begin  // Shift complete
                            limit <= (delay + 1) * 1000;
                        end
                    end
                end
                
                COUNTING: begin
                    counting <= 1'b1;
                    if (counter < limit) begin
                        counter <= counter + 1;
                    end
                    else begin
                        counter <= 14'b0;
                        counting <= 1'b0;
                    end
                end
                
                DONE: begin
                    done <= 1'b1;
                    counting <= 1'b0;
                end
            endcase
        end
    end

endmodule
