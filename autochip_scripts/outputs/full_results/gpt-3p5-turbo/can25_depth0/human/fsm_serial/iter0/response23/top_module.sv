module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        RECEIVE_DATA,
        STOP_BIT
    } state_t;
    
    // Define state register
    state_t current_state, next_state;
    
    // Define data register
    reg [7:0] data_reg;
    reg [2:0] bit_count;
    reg done_reg;
    
    // Synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_reg <= 8'b0;
            bit_count <= 0;
            done_reg <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == STOP_BIT) begin
                done_reg <= 1;
            end
        end
    end
    
    // Next state logic
    always_comb begin
        case (current_state)
            IDLE:
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end else begin
                    next_state = IDLE;
                end
            START_BIT:
                if (in == 1'b0) begin
                    next_state = RECEIVE_DATA;
                    bit_count = 0;
                end else begin
                    next_state = IDLE;
                end
            RECEIVE_DATA:
                if (bit_count < 7) begin
                    next_state = RECEIVE_DATA;
                    bit_count = bit_count + 1;
                end else begin
                    next_state = STOP_BIT;
                    bit_count = 0;
                end
            STOP_BIT:
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = STOP_BIT;
                end
            default:
                next_state = IDLE;
        endcase
    end
    
    // Output assignment
    assign done = done_reg;
    
endmodule
