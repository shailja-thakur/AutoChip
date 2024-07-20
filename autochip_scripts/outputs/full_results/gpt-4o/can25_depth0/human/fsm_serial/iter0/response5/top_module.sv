module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE      = 4'b0000,
        START_BIT = 4'b0001,
        BIT0      = 4'b0010,
        BIT1      = 4'b0011,
        BIT2      = 4'b0100,
        BIT3      = 4'b0101,
        BIT4      = 4'b0110,
        BIT5      = 4'b0111,
        BIT6      = 4'b1000,
        BIT7      = 4'b1001,
        STOP_BIT  = 4'b1010,
        ERROR     = 4'b1011
    } state_t;

    state_t current_state, next_state;
    reg [7:0] data;
    reg [2:0] bit_counter;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        next_state = current_state; // Default to hold state
        done = 1'b0;                // Default done signal

        case (current_state)
            IDLE: begin
                if (in == 1'b0)      // Start bit detected
                    next_state = START_BIT;
            end

            START_BIT: next_state = BIT0; // Move to BIT0 after start bit

            BIT0: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;

            BIT7: begin
                next_state = STOP_BIT; // Move to STOP_BIT after BIT7
            end

            STOP_BIT: begin
                if (in == 1'b1) begin // Correct stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end 
                else begin
                    next_state = ERROR; // Error state if stop bit is incorrect
                end
            end

            ERROR: begin
                if (in == 1'b1) // Wait until line is idle
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Output logic for data capturing
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 8'b0;
            bit_counter <= 3'b0;
        end
        else if (current_state >= BIT0 && current_state <= BIT7) begin
            data[bit_counter] <= in;
            bit_counter <= bit_counter + 1;
        end
        else if (current_state == IDLE) begin
            bit_counter <= 3'b0; // Reset bit counter in IDLE state
        end
    end

endmodule
