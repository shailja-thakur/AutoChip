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

// Define the states of the state machine
localparam STATE_SEARCH  = 3'd0;
localparam STATE_SHIFT   = 3'd1;
localparam STATE_COUNT   = 3'd2;
localparam STATE_NOTIFY  = 3'd3;
localparam STATE_WAIT    = 3'd4;

reg [2:0] state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_SEARCH;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        shift_count <= 4'b0;
    end
    else begin
        case (state)
            STATE_SEARCH: begin
                // Search for the start sequence 1101
                if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                    state <= STATE_SHIFT;
                    shift_count <= 4'b0;
                end
                else begin
                    state <= STATE_SEARCH;
                end
            end
            STATE_SHIFT: begin
                // Shift in 4 more bits to determine the duration
                shift_ena <= 1'b1;
                shift_count <= shift_count + 1'b1;
                if (shift_count == 4'b0100) begin
                    state <= STATE_COUNT;
                    shift_ena <= 1'b0;
                end
            end
            STATE_COUNT: begin
                // Wait for the counters to finish
                counting <= 1'b1;
                if (done_counting) begin
                    state <= STATE_NOTIFY;
                    counting <= 1'b0;
                end
            end
            STATE_NOTIFY: begin
                // Notify the user and wait for acknowledgment
                done <= 1'b1;
                if (ack) begin
                    state <= STATE_SEARCH;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= STATE_SEARCH;
            end
        endcase
    end
end

endmodule
