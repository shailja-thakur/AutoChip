module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE          = 3'b000,
        START_BIT     = 3'b001,
        DATA_BITS     = 3'b010,
        STOP_BIT      = 3'b011,
        ERROR         = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter; // Counter for bits (0-7 for data bits)

    // FSM sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b000;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 3'b000;
            end
            if (state == STOP_BIT && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // FSM combinational logic
    always @(*) begin
        next_state = state; // Default transition is to stay in the current state
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_counter == 3'b111) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = DATA_BITS;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
