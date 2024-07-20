module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_counter;

    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                done = 1'b0;
                if (in == 1'b0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            
            START: begin
                done = 1'b0;
                if (in == 1'b0) begin
                    next_state = DATA;
                    bit_counter = 3'd0;
                end else begin
                    next_state = IDLE;
                end
            end
            
            DATA: begin
                done = 1'b0;
                if (bit_counter == 3'd7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                    bit_counter = bit_counter + 1;
                end
            end
            
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    done = 1'b0;
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                done = 1'b0;
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
