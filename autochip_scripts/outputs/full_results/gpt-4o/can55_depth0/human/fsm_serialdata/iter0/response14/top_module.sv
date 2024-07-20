module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // FSM State encoding
    typedef enum logic [3:0] {
        IDLE,           // Waiting for start bit
        START,          // Start bit received
        DATA_BITS,      // Receiving 8 data bits
        STOP            // Stop bit received
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;   // Counter for data bits received
    reg [7:0] data_byte;   // Temporary storage for the data byte being received

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (!in)        // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'b111) // All 8 data bits received
                    next_state = STOP;
                else
                    next_state = DATA_BITS;
            end

            STOP: begin
                if (in)         // Stop bit detected
                    next_state = IDLE;
                else
                    next_state = STOP;
            end

            default: next_state = IDLE;
        endcase
    end

    // Output and data loading logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out_byte <= 8'b0;
            done <= 1'b0;
            data_byte <= 8'b0;
            bit_count <= 3'b0;
        end else begin
            done <= 1'b0; // Default to 0 unless set in STOP state
            case (current_state)
                IDLE: begin
                    bit_count <= 3'b0;
                end

                START: begin
                    // Do nothing
                end

                DATA_BITS: begin
                    data_byte[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end

                STOP: begin
                    if (in) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                    end
                end
            endcase
        end
    end

endmodule
