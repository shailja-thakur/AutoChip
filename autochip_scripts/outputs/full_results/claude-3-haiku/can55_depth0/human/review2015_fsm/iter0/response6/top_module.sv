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

reg [3:0] state;
reg [3:0] pattern;

// Defining the states
localparam SEARCH = 4'd0;
localparam SHIFT  = 4'd1;
localparam COUNT  = 4'd2;
localparam NOTIFY = 4'd3;
localparam WAIT   = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        pattern <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            SEARCH: begin
                // Shift in the new bit
                pattern <= {pattern[2:0], data};

                // Check if the pattern is 1101
                if (pattern == 4'b1101) begin
                    state <= SHIFT;
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                end

                counting <= 1'b0;
                done <= 1'b0;
            end

            SHIFT: begin
                // Shift in the duration bits
                pattern <= {pattern[2:0], data};
                shift_ena <= 1'b1;

                // After 4 cycles, move to the COUNT state
                if (pattern[3]) begin
                    state <= COUNT;
                    shift_ena <= 1'b0;
                end
            end

            COUNT: begin
                // Wait for the counters to finish
                counting <= 1'b1;
                if (done_counting) begin
                    state <= NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end

            NOTIFY: begin
                // Wait for the user to acknowledge
                if (ack) begin
                    state <= SEARCH;
                end
            end

            default: begin
                state <= SEARCH;
            end
        endcase
    end
end

endmodule
