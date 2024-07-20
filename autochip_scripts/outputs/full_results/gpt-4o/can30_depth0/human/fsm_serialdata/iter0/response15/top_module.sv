module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum reg [3:0] {
        IDLE       = 4'b0000,
        START      = 4'b0001,
        BIT_0      = 4'b0010,
        BIT_1      = 4'b0011,
        BIT_2      = 4'b0100,
        BIT_3      = 4'b0101,
        BIT_4      = 4'b0110,
        BIT_5      = 4'b0111,
        BIT_6      = 4'b1000,
        BIT_7      = 4'b1001,
        STOP       = 4'b1010
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_register;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
            if (state == START || state == BIT_0 || state == BIT_1 || state == BIT_2 || state == BIT_3 || state == BIT_4 || state == BIT_5 || state == BIT_6 || state == BIT_7) begin
                shift_register <= {in, shift_register[7:1]}; // Shift incoming bit
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin  // Detect start bit
                    next_state = START;
                end
            end
            
            START: begin
                next_state = BIT_0;
            end
            
            BIT_0: begin
                next_state = BIT_1;
            end
            
            BIT_1: begin
                next_state = BIT_2;
            end
            
            BIT_2: begin
                next_state = BIT_3;
            end
            
            BIT_3: begin
                next_state = BIT_4;
            end
            
            BIT_4: begin
                next_state = BIT_5;
            end
            
            BIT_5: begin
                next_state = BIT_6;
            end
            
            BIT_6: begin
                next_state = BIT_7;
            end
            
            BIT_7: begin
                next_state = STOP;
            end
            
            STOP: begin
                if (in == 1'b1) begin  // Check stop bit
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = IDLE;  // Go back to IDLE if stop bit is not detected
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output byte logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_byte <= 8'b0;
        end else if (done) begin
            out_byte <= shift_register;
        end
    end
endmodule
