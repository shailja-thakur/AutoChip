module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State machine states
    parameter STATE_SEARCH = 3'b000;
    parameter STATE_CAPTURE = 3'b001;
    parameter STATE_DELAY = 3'b010;
    parameter STATE_NOTIFY = 3'b011;

    reg [2:0] state;
    reg [3:0] delay;
    reg [9:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_SEARCH;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                STATE_SEARCH: begin
                    // Search for the start sequence 1101
                    if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                        state <= STATE_CAPTURE;
                    end
                    counting <= 0;
                    done <= 0;
                end

                STATE_CAPTURE: begin
                    // Capture the delay value
                    delay <= {data, data, data, data};
                    state <= STATE_DELAY;
                    counting <= 1;
                    done <= 0;
                end

                STATE_DELAY: begin
                    // Count down the delay
                    if (counter == (delay + 1) * 1000 - 1) begin
                        counter <= 0;
                        state <= STATE_NOTIFY;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                STATE_NOTIFY: begin
                    // Wait for user acknowledgement
                    if (ack) begin
                        state <= STATE_SEARCH;
                        done <= 0;
                    end
                end

                default: begin
                    state <= STATE_SEARCH;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end

    assign count = (state == STATE_DELAY) ? delay - (counter / 1000) : 4'hx;

endmodule
