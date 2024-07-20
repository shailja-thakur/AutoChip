module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [2:0] state, next_state;
    reg [3:0] counter;
    reg [12:0] total_count;
    reg [3:0] delay;

    localparam RESET = 0,
               SEARCH = 1,
               READ_DELAY = 2,
               COUNT = 3,
               WAIT_ACK = 4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RESET;
            counting <= 0;
            done <= 0;
            counter <= 0;
            total_count <= 0;
            delay <= 0;
        end else begin
            state <= next_state;
            case (state)
                RESET: begin
                    done <= 0;
                    counting <= 0;
                end
                SEARCH: begin
                    counter[3:0] <= {counter[2:0], data};
                    if (counter[3:0] == 4'b1101) begin
                        next_state <= READ_DELAY;
                        counter <= 0;
                    end
                end
                READ_DELAY: begin
                    delay[3:0] <= {delay[2:0], data};
                    counter <= counter + 1;
                    if (counter == 3) begin
                        total_count <= (delay + 1) * 1000;
                        count <= delay;
                        next_state <= COUNT;
                        counter <= 0;
                    end
                end
                COUNT: begin
                    counting <= 1;
                    if (total_count > 0) begin
                        total_count <= total_count - 1;
                        if (total_count % 1000 == 0)
                            count <= count - 1;
                    end else begin
                        counting <= 0;
                        done <= 1;
                        next_state <= WAIT_ACK;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        next_state <= SEARCH;
                        done <= 0;
                        delay <= 0;
                        total_count <= 0;
                    end
                end
                default: next_state <= SEARCH;
            endcase
        end
    end
    
    always @(*) begin
        case (state)
            RESET: next_state = SEARCH;
            SEARCH: next_state = SEARCH;
            READ_DELAY: next_state = state;
            COUNT: next_state = state;
            WAIT_ACK: next_state = state;
            default: next_state = SEARCH;
        endcase
    end

endmodule
