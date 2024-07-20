module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining;

    enum {IDLE, DETECT, SHIFT, COUNT, DONE} state;
    reg [3:0] state_delay;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            remaining <= 0;
            counting <= 0;
            done <= 0;
            count <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state_delay <= delay;
                        state <= DETECT;
                    end
                end
                DETECT: begin
                    state <= SHIFT;
                end
                SHIFT: begin
                    state <= COUNT;
                end
                COUNT: begin
                    if (state_delay == 0) begin
                        counting <= 1;
                        state <= DONE;
                    end else begin
                        state <= COUNT;
                        state_delay <= state_delay - 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        counting <= 0;
                        done <= 1;
                        state <= IDLE;
                    end
                    else begin
                        state <= DONE;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (counting && (remaining == 0)) begin
                count <= delay;
            end else begin
                count <= remaining;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            remaining <= 0;
        end else begin
            if (counting && (remaining > 0)) begin
                remaining <= remaining - 1;
            end else if (counting && (remaining == 0)) begin
                remaining <= delay;
            end
        end
    end

endmodule
