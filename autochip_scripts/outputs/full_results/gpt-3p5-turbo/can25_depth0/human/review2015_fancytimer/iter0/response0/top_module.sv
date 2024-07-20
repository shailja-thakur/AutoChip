module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] time_left;
    reg [3:0] shift_reg;
    reg start_found;
    reg [3:0] state;

    parameter IDLE = 4'b0000;
    parameter START_FOUND = 4'b0001;
    parameter SHIFT_IN_DELAY = 4'b0010;
    parameter COUNTING = 4'b0011;
    parameter DONE = 4'b0100;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            delay <= 0;
            time_left <= 0;
            shift_reg <= 0;
            start_found <= 0;
        end else begin
            case (state)
                IDLE:
                    if (data == 1'b1 && shift_reg == 4'b1101) begin
                        start_found <= 1;
                        state <= SHIFT_IN_DELAY;
                    end else begin
                        start_found <= 0;
                        state <= IDLE;
                    end
                SHIFT_IN_DELAY:
                    delay <= shift_reg;
                    state <= COUNTING;
                COUNTING:
                    counting <= 1;
                    time_left <= delay;
                    if (time_left > 0) begin
                        time_left <= time_left - 1;
                        state <= COUNTING;
                    end else begin
                        counting <= 0;
                        done <= 1;
                        state <= DONE;
                    end
                DONE:
                    if (ack == 1'b1) begin
                        done <= 0;
                        state <= IDLE;
                    end else begin
                        done <= 1;
                        state <= DONE;
                    end
            endcase
        end
    end

    assign count = time_left;

endmodule
