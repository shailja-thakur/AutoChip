module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE = 4'd0,
        START = 4'd1,
        DATA_0 = 4'd2,
        DATA_1 = 4'd3,
        DATA_2 = 4'd4,
        DATA_3 = 4'd5,
        DATA_4 = 4'd6,
        DATA_5 = 4'd7,
        DATA_6 = 4'd8,
        DATA_7 = 4'd9,
        STOP = 4'd10
    } state_t;
    
    state_t state, next_state;
    reg [7:0] data_bits;
    reg [2:0] bit_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == IDLE) begin
                bit_count <= 3'd0;
                done <= 0;
            end else if (state >= START && state <= DATA_7) begin
                data_bits[bit_count] <= in;
                bit_count <= bit_count + 3'd1;
            end else if (state == STOP) begin
                done <= (in == 1'b1) ? 1 : 0;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)  // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA_0;
            end
            DATA_0: next_state = DATA_1;
            DATA_1: next_state = DATA_2;
            DATA_2: next_state = DATA_3;
            DATA_3: next_state = DATA_4;
            DATA_4: next_state = DATA_5;
            DATA_5: next_state = DATA_6;
            DATA_6: next_state = DATA_7;
            DATA_7: next_state = STOP;
            STOP: begin
                if (in == 1'b1)  // Proper stop bit detected
                    next_state = IDLE;  // Go to IDLE to wait for next start bit
                else
                    next_state = STOP;  // If stop bit is not correct, remain in STOP until correct stop bit found
            end
            default: next_state = IDLE;
        endcase
    end
    
endmodule
