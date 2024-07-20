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
    SEARCH = 4'b0000,
    SHIFT = 4'b0001,
    COUNT = 4'b0010,
    NOTIFY = 4'b0011,
    WAIT = 4'b0100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= SEARCH;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        pattern <= 0;
    end
    else begin
        case (state)
            SEARCH: begin
                if (data) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= SHIFT;
                        shift_ena <= 1;
                    end
                    else begin
                        shift_ena <= 0;
                    end
                end
                else begin
                    shift_ena <= 0;
                end
            end
            SHIFT: begin
                if (shift_ena) begin
                    pattern <= {pattern[2:0], data};
                    if (shift_ena == 1) begin
                        shift_ena <= 0;
                        state <= COUNT;
                        counting <= 1;
                    end
                end
            end
            COUNT: begin
                if (done_counting) begin
                    counting <= 0;
                    state <= NOTIFY;
                    done <= 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    done <= 0;
                    state <= SEARCH;
                end
            end
            default: state <= SEARCH;
        endcase
    end
end

endmodule
