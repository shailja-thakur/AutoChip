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

    localparam [3:0] WAIT_PATTERN = 4'd0,
                    SHIFT_DURATION = 4'd1,
                    WAIT_COUNTING = 4'd2,
                    NOTIFY_USER = 4'd3;

    reg [3:0] state, next_state;
    reg [3:0] shift_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            shift_count <= 4'd0;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            case (state)
                WAIT_PATTERN: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if ({data, shift_count[3:1]} == 4'b1101) begin
                        shift_count <= 4'd0;
                        next_state <= SHIFT_DURATION;
                    end
                    else begin
                        shift_count <= {data, shift_count[3:1]};
                        next_state <= WAIT_PATTERN;
                    end
                end
                SHIFT_DURATION: begin
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (shift_count == 4'd4) begin
                        shift_ena <= 1'b0;
                        next_state <= WAIT_COUNTING;
                    end
                    else begin
                        shift_count <= shift_count + 1'b1;
                        next_state <= SHIFT_DURATION;
                    end
                end
                WAIT_COUNTING: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    done <= 1'b0;
                    if (done_counting) begin
                        counting <= 1'b0;
                        next_state <= NOTIFY_USER;
                    end
                    else begin
                        next_state <= WAIT_COUNTING;
                    end
                end
                NOTIFY_USER: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        done <= 1'b0;
                        next_state <= WAIT_PATTERN;
                    end
                    else begin
                        next_state <= NOTIFY_USER;
                    end
                end
                default: begin
                    next_state <= WAIT_PATTERN;
                end
            endcase
        end
    end

endmodule
