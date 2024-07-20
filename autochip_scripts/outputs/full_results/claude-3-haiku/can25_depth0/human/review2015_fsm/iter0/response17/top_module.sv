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

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        pattern <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Searching for start pattern 1101
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= 1;
                    shift_ena <= 1;
                end
                else begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            end
            1: begin // Shifting in duration
                shift_ena <= 1;
                if (shift_ena == 1) begin
                    pattern <= {pattern[2:0], data};
                end
                if (shift_ena == 1 && pattern == 4'b0000) begin
                    shift_ena <= 0;
                    state <= 2;
                end
            end
            2: begin // Waiting for counters
                counting <= 1;
                if (done_counting) begin
                    state <= 3;
                    counting <= 0;
                    done <= 1;
                end
            end
            3: begin // Waiting for acknowledge
                done <= 1;
                if (ack) begin
                    state <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
