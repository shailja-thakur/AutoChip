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
    reg [3:0] remaining;

    reg [3:0] state;
    parameter IDLE = 4'b0000;
    parameter SEARCH = 4'b0001;
    parameter SHIFT = 4'b0010;
    parameter COUNT = 4'b0011;
    parameter DONE_WAIT = 4'b0100;
    parameter RESET_STATE = 4'b0101;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RESET_STATE;
            counting <= 0;
            done <= 0;
            delay <= 4'b0000;
            counter <= 4'b0000;
            remaining <= 4'b0000;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        state <= SEARCH;
                    end
                end
                SEARCH: begin
                    if (data == 1'b1) begin
                        state <= SHIFT;
                    end else begin
                        state <= IDLE;
                    end
                end
                SHIFT: begin
                    delay <= {data, delay[3:1]};
                    counter <= delay;
                    state <= COUNT;
                end
                COUNT: begin
                    if (counter == 4'b0000) begin
                        state <= DONE_WAIT;
                    end else begin
                        counting <= 1;
                        count <= counter;
                        remaining <= counter;
                        counter <= counter - 1;
                    end
                end
                DONE_WAIT: begin
                    if (ack) begin
                        state <= RESET_STATE;
                        counting <= 0;
                        done <= 1;
                    end
                end
                RESET_STATE: begin
                    if (data == 1'b1) begin
                        state <= SEARCH;
                    end else begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == COUNT) begin
            if (counter == 4'b0000) begin
                counting <= 0;
            end else begin
                counting <= 1;
                counter <= counter - 1;
                if (counter[3]) begin
                    remaining <= counter - 1;
                end else begin
                    remaining <= counter;
                end
            end
        end
    end

endmodule
