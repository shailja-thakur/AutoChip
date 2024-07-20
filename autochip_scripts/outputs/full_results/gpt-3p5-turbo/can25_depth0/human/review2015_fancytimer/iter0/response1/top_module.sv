module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] state;

    parameter IDLE_STATE = 0;
    parameter DETECT_STATE = 1;
    parameter COUNT_STATE = 2;
    parameter DONE_STATE = 3;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE_STATE;
            count <= 4'b0;
            delay <= 4'b0;
            counting <= 0;
            done <= 0;
            remaining_time <= 4'b0;
        end else begin
            case (state)
                IDLE_STATE: begin
                    if (data == 1'b1) begin
                        state <= DETECT_STATE;
                        count <= 4'b0;
                        delay <= 4'b0;
                        counting <= 1;
                        done <= 0;
                        remaining_time <= 4'b0;
                    end
                end
                DETECT_STATE: begin
                    count <= count + 1;
                    if (count == 4'b1111) begin
                        delay <= data;
                        state <= COUNT_STATE;
                        count <= 4'b0;
                    end
                end
                COUNT_STATE: begin
                    if (count == delay) begin
                        counting <= 0;
                        state <= DONE_STATE;
                        count <= 4'b0;
                    end else begin
                        count <= count + 1;
                        remaining_time <= delay - count - 1;
                    end
                end
                DONE_STATE: begin
                    if (ack == 1'b1) begin
                        state <= IDLE_STATE;
                        count <= 4'b0;
                        delay <= 4'b0;
                        counting <= 0;
                        done <= 1;
                        remaining_time <= 4'b0;
                    end
                end
            endcase
        end
    end

endmodule
