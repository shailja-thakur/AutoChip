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

localparam [3:0] 
    S_WAIT_PATTERN = 4'b0000,
    S_SHIFT_DURATION = 4'b0001,
    S_COUNTING = 4'b0010,
    S_DONE = 4'b0011;

always @(posedge clk) begin
    if (reset) begin
        state <= S_WAIT_PATTERN;
        pattern <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            S_WAIT_PATTERN: begin
                if (data) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= S_SHIFT_DURATION;
                        shift_ena <= 1;
                    end
                    else begin
                        shift_ena <= 0;
                    end
                end
                else begin
                    pattern <= {pattern[2:0], data};
                    shift_ena <= 0;
                end
            end
            
            S_SHIFT_DURATION: begin
                if (shift_ena) begin
                    shift_ena <= shift_ena - 1;
                end
                else begin
                    state <= S_COUNTING;
                    counting <= 1;
                end
            end
            
            S_COUNTING: begin
                if (done_counting) begin
                    state <= S_DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            
            S_DONE: begin
                if (ack) begin
                    state <= S_WAIT_PATTERN;
                    done <= 0;
                end
            end
            
            default: state <= S_WAIT_PATTERN;
        endcase
    end
end

endmodule
