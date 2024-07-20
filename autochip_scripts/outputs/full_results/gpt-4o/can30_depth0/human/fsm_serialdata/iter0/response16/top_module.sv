module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [3:0] {
        IDLE = 4'd0,
        START_BIT = 4'd1,
        BIT0 = 4'd2,
        BIT1 = 4'd3,
        BIT2 = 4'd4,
        BIT3 = 4'd5,
        BIT4 = 4'd6,
        BIT5 = 4'd7,
        BIT6 = 4'd8,
        BIT7 = 4'd9,
        STOP_BIT = 4'd10
    } state_t;
    
    reg [3:0] state, next_state;
    reg [7:0] data_byte;  // Temporary storage for the received byte
    reg [2:0] bit_count;  // Counter for the bits received

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 0;
            done <= 0;
            data_byte <= 0;
            bit_count <= 0;
        end else begin
            state <= next_state;
            if (next_state == STOP_BIT) begin
                out_byte <= data_byte;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    always @(*) begin
        next_state = state;  // Default to stay in the same state
        case (state)
            IDLE: begin
                if (in == 0) begin  // Look for the start bit
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = BIT0;
            end
            BIT0: begin
                data_byte[0] = in;
                next_state = BIT1;
            end
            BIT1: begin
                data_byte[1] = in;
                next_state = BIT2;
            end
            BIT2: begin
                data_byte[2] = in;
                next_state = BIT3;
            end
            BIT3: begin
                data_byte[3] = in;
                next_state = BIT4;
            end
            BIT4: begin
                data_byte[4] = in;
                next_state = BIT5;
            end
            BIT5: begin
                data_byte[5] = in;
                next_state = BIT6;
            end
            BIT6: begin
                data_byte[6] = in;
                next_state = BIT7;
            end
            BIT7: begin
                data_byte[7] = in;
                next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1) begin  // Check for the stop bit
                    next_state = IDLE;
                end else begin
                    next_state = STOP_BIT;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
