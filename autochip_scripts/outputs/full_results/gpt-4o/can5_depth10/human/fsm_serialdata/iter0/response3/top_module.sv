module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State declaration
    typedef enum reg [3:0] {
        IDLE      = 4'd0,
        START     = 4'd1,
        BIT0      = 4'd2,
        BIT1      = 4'd3,
        BIT2      = 4'd4,
        BIT3      = 4'd5,
        BIT4      = 4'd6,
        BIT5      = 4'd7,
        BIT6      = 4'd8,
        BIT7      = 4'd9,
        STOP      = 4'd10,
        ERROR     = 4'd11
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;  // To keep track of which bit we are on
    reg [7:0] shift_reg;    // Shift register to capture incoming byte

    // FSM state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM next state logic
    always @(*) begin
        next_state = state;  // Default to maintain the same state
        done = 1'b0;         // Default done signal to 0

        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;  // Detect start bit
            end
            START: begin
                next_state = BIT0;  // Move to receive bit 0
            end
            BIT0: begin
                next_state = BIT1;
            end
            BIT1: begin
                next_state = BIT2;
            end
            BIT2: begin
                next_state = BIT3;
            end
            BIT3: begin
                next_state = BIT4;
            end
            BIT4: begin
                next_state = BIT5;
            end
            BIT5: begin
                next_state = BIT6;
            end
            BIT6: begin
                next_state = BIT7;
            end
            BIT7: begin
                next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin  // Verify stop bit
                    next_state = IDLE;
                    done = 1'b1;  // Signal that a byte has been successfully received
                end else
                    next_state = ERROR;  // Error state if stop bit was not correct
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;  // Wait for idle line to return to high
            end
        endcase
    end

    // FSM output logic and bit reception
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'b0;
            bit_counter <= 3'd0;
            out_byte <= 8'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_counter <= 3'd0;
                end
                BIT0, BIT1, BIT2, BIT3, BIT4, BIT5, BIT6, BIT7: begin
                    shift_reg <= {in, shift_reg[7:1]};  // Shift in the incoming bits
                    bit_counter <= bit_counter + 1;
                end
                STOP: begin
                    if (in == 1'b1)  // Only update out_byte if stop bit is correct
                        out_byte <= shift_reg;
                end
            endcase
        end
    end
endmodule
