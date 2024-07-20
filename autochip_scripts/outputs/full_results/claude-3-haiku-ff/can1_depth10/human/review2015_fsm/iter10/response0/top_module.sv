module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

// Define the states of the finite state machine
localparam [2:0] WAIT_START = 3'b000,
                SHIFT_DURATION = 3'b001,
                COUNTING = 3'b010,
                NOTIFY_USER = 3'b011;

reg [2:0] state, next_state;
reg [3:0] bit_count;
reg [3:0] duration;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        bit_count <= 0;
        duration <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                // Wait for the start sequence 1101
                if (data == 1'b1 && bit_count == 0) bit_count <= 1;
                else if (data == 1'b1 && bit_count == 1) bit_count <= 2;
                else if (data == 1'b0 && bit_count == 2) bit_count <= 3;
                else if (data == 1'b1 && bit_count == 3) begin
                    bit_count <= 0;
                    next_state <= SHIFT_DURATION;
                    duration <= 0; // Reset duration when start pattern is detected
                end
                else bit_count <= 0;
            end
            SHIFT_DURATION: begin
                // Shift in 4 more bits to determine the duration
                shift_ena <= 1;
                duration[bit_count] <= data;
                if (bit_count == 3) begin
                    shift_ena <= 0;
                    next_state <= COUNTING;
                end
                else bit_count <= bit_count + 1;
            end
            COUNTING: begin
                // Wait for the counters to finish
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY_USER;
                end
            end
            NOTIFY_USER: begin
                // Notify the user and wait for acknowledgment
                done <= 1;
                if (ack) begin
                    done <= 0;
                    next_state <= WAIT_START;
                end
            end
        endcase
        state <= next_state;
    end
end

endmodule
