module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        ERROR      = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 4'd0;
            end
        end
    end

    always_ff @(posedge clk) begin
        done <= 1'b0; // Clear done at every clock cycle
        next_state = state;
        case(state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit (logic 0)
                    next_state = START_BIT;
                end else begin
                    next_state = IDLE;
                end
            end
            
            START_BIT: begin
                next_state = DATA_BITS; // Move to DATA_BITS next clock cycle
            end
            
            DATA_BITS: begin
                if (bit_count == 4'd8) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = DATA_BITS;
                end
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin // Expect stop bit (logic 1)
                    done = 1'b1; // Assert done signal
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // If stop bit is not 1, go to error state
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin // Wait for line to return to idle state (logic 1)
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
