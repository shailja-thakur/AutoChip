module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State declarations
    typedef enum logic [2:0] {
        IDLE,         // Waiting for 1101
        LOAD_DELAY,   // Loading the delay value
        COUNT_DOWN,   // Counting down
        WAIT_ACK      // Waiting for ack signal
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_counter;
    reg [3:0] delay;
    reg [13:0] cycle_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 4'd0;
            delay <= 4'd0;
            cycle_counter <= 14'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == IDLE || state == WAIT_ACK) begin
                bit_counter <= 4'd0;
                delay <= 4'd0;
                cycle_counter <= 14'd0;
                counting <= 1'b0;
            end
            if (state == LOAD_DELAY && (next_state == COUNT_DOWN)) begin
                delay <= {delay[2:0], data};  
            end
            if (state == COUNT_DOWN) begin
                if (cycle_counter == 14'd999 && count > 4'd0) begin
                    count <= count - 1;
                    cycle_counter <= 14'd0;
                end
                else
                    cycle_counter <= cycle_counter + 1;
            end
            if (next_state == IDLE) begin
                done <= 1'b0;
            end
            if (next_state == WAIT_ACK) begin
                done <= 1'b1;
                counting <= 1'b0;
            end
            if (next_state == COUNT_DOWN) begin
                counting <= 1'b1;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if ({bit_counter[2:0], data} == 4'b1101) begin
                    next_state = LOAD_DELAY;
                    bit_counter = 4'd1;
                end
                else
                    bit_counter = bit_counter + 1;
            end
            LOAD_DELAY: begin
                if (bit_counter == 4'd4)
                    next_state = COUNT_DOWN;
                else begin
                    next_state = LOAD_DELAY;
                    bit_counter = bit_counter + 1;
                end
            end
            COUNT_DOWN: begin
                if (count == 4'd0 && cycle_counter == 14'd999)
                    next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    assign count = (state == COUNT_DOWN) ? (delay - cycle_counter / 1000) : 4'dx; // Don't care value when not counting
endmodule
