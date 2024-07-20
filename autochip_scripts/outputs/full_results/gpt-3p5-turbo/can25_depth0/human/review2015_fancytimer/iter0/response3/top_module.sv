module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] shift_register;
    reg [3:0] next_state;

    parameter IDLE = 4'b0000;
    parameter START_SEARCH = 4'b0001;
    parameter RECEIVE_DELAY = 4'b0010;
    parameter COUNT = 4'b0011;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            remaining_time <= 0;
            shift_register <= 0;
            next_state <= START_SEARCH;
        end else begin
            case (next_state)
                IDLE:
                    if (data == 4'b1101) begin
                        next_state <= RECEIVE_DELAY;
                        remaining_time <= delay + 1;
                    end else begin
                        next_state <= IDLE;
                    end
                START_SEARCH:
                    if (data == 4'b1101) begin
                        next_state <= RECEIVE_DELAY;
                        shift_register <= 0;
                        remaining_time <= delay + 1;
                    end else begin
                        next_state <= START_SEARCH;
                        shift_register <= {shift_register[2:0], data};
                    end
                RECEIVE_DELAY:
                    shift_register <= {shift_register[2:0], data};
                    delay <= shift_register;
                    next_state <= COUNT;
                    counting <= 1;
                COUNT:
                    if (remaining_time == 0) begin
                        next_state <= IDLE;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        remaining_time <= remaining_time - 1;
                        next_state <= COUNT;
                    end
                default:
                    next_state <= IDLE;
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bXXXX;
    
endmodule
