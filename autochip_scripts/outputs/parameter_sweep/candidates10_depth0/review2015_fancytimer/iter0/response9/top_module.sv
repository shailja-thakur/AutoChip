module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] shift_reg;
    reg [3:0] delay;

    reg [3:0] counter;
    reg [3:0] remaining_time;

    reg [3:0] state;
    reg [3:0] next_state;

    parameter RESET_STATE = 4'b0000;
    parameter SEARCH_STATE = 4'b0001;
    parameter SHIFT_STATE = 4'b0010;
    parameter COUNT_STATE = 4'b0011;
    parameter WAIT_STATE = 4'b0100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            counting <= 0;
            done <= 0;
            state <= RESET_STATE;
        end else begin
            case (state)
                RESET_STATE: begin
                    shift_reg <= 4'b0000;
                    delay <= 4'b0000;
                    counting <= 0;
                    done <= 0;
                    if (data == 4'b1101) begin
                        state <= SEARCH_STATE;
                    end
                end
                SEARCH_STATE: begin
                    if (data == 4'b1101) begin
                        state <= SHIFT_STATE;
                    end
                end
                SHIFT_STATE: begin
                    shift_reg <= {shift_reg[2:0], data};
                    state <= COUNT_STATE;
                end
                COUNT_STATE: begin
                    counting <= 1;
                    counter <= (delay + 1) * 1000;
                    remaining_time <= delay;
                    state <= WAIT_STATE;
                end
                WAIT_STATE: begin
                    counting <= 1;
                    counter <= counter - 1;
                    if (counter == 0) begin
                        counting <= 0;
                        done <= 1;
                        state <= RESET_STATE;
                    else if (counter % 1000 == 0) begin
                        remaining_time <= remaining_time - 1;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        case (state)
            COUNT_STATE: begin
                counter <= counter - 1;
                if (counter == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= RESET_STATE;
                else if (counter % 1000 == 0) begin
                    remaining_time <= remaining_time - 1;
                end
            end
        endcase
    end

    assign count = remaining_time;

endmodule
