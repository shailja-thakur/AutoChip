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

// Define the states
parameter [2:0] 
    WAIT_START = 3'd0,
    SHIFT_COUNT = 3'd1,
    WAIT_DONE = 3'd2,
    NOTIFY_USER = 3'd3;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        
        case (state)
            WAIT_START: begin
                // Look for the 1101 start sequence
                if (data == 1'b1) begin
                    shift_count <= 1;
                    next_state <= SHIFT_COUNT;
                end
                else begin
                    shift_count <= 0;
                    next_state <= WAIT_START;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            
            SHIFT_COUNT: begin
                // Shift in 4 more bits
                if (shift_count < 4'd5) begin
                    shift_count <= shift_count + 1;
                    shift_ena <= 1;
                    next_state <= SHIFT_COUNT;
                end
                else begin
                    shift_ena <= 0;
                    next_state <= WAIT_DONE;
                end
                counting <= 0;
                done <= 0;
            end
            
            WAIT_DONE: begin
                // Wait for the counters to finish
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                end
                else begin
                    next_state <= WAIT_DONE;
                end
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            
            NOTIFY_USER: begin
                // Notify the user and wait for acknowledgement
                if (ack) begin
                    next_state <= WAIT_START;
                end
                else begin
                    next_state <= NOTIFY_USER;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
            
            default: begin
                next_state <= WAIT_START;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
