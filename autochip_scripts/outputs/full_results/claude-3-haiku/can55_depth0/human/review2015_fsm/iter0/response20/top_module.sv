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

localparam [1:0] 
    SEARCH = 2'b00,
    SHIFT  = 2'b01,
    COUNT  = 2'b10,
    NOTIFY = 2'b11;

reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            SEARCH: begin
                // Look for the start pattern 1101
                if (data == 1'b1) begin
                    if (shift_count == 3) begin
                        next_state <= SHIFT;
                        shift_count <= 0;
                    end
                    else begin
                        shift_count <= shift_count + 1;
                    end
                end
                else begin
                    shift_count <= 0;
                end
            end
            SHIFT: begin
                // Shift in the 4 timing bits
                shift_ena <= 1;
                if (shift_count == 4) begin
                    shift_ena <= 0;
                    next_state <= COUNT;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            COUNT: begin
                // Wait for the counters to finish
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY;
                end
            end
            NOTIFY: begin
                // Notify the user and wait for acknowledgement
                done <= 1;
                if (ack) begin
                    done <= 0;
                    next_state <= SEARCH;
                end
            end
        endcase
    end
end

endmodule
