module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );


    reg [3:0] delay;
    reg [3:0] counter;
    reg [3:0] remaining_time;
    reg [3:0] next_state;
    reg [3:0] state;

    parameter IDLE = 4'b0000;
    parameter SEARCH = 4'b0001;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= SEARCH;
            counting <= 0;
            done <= 0;
            delay <= 0;
            counter <= 0;
        end else begin
            case (state)
                SEARCH: begin
                    if (data == 4'b1101) begin
                        state <= next_state;
                        delay <= data;
                        counter <= (delay + 1) * 1000;
                        counting <= 1;
                    end else begin
                        state <= SEARCH;
                        counting <= 0;
                        done <= 0;
                        delay <= 0;
                        counter <= 0;
                    end
                end
                default: begin
                    if (counter == 0) begin
                        state <= SEARCH;
                        counting <= 0;
                        done <= 1;
                        delay <= 0;
                        counter <= 0;
                    end else begin
                        state <= next_state;
                        counting <= 1;
                        done <= 0;
                        delay <= delay;
                        counter <= counter - 1;
                    end
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            SEARCH: next_state = SEARCH;
            default: next_state = delay == 0 ? SEARCH : state;
        endcase
    end

    always @(counter) begin
        remaining_time = state == IDLE ? delay : counter / 1000;
    end

    assign count = counter;

endmodule
