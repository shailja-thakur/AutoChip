module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [2:0] state;
    reg [15:0] counter;
    reg [15:0] duration;

    localparam IDLE = 0;
    localparam START = 1;
    localparam SHIFT = 2;
    localparam COUNT = 3;
    localparam DONE = 4;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0;
            counting <= 0;
            done <= 0;
            duration <= 0;
            counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= START;
                    end
                end
                START: begin
                    state <= SHIFT;
                    duration <= 4'b0;
                end
                SHIFT: begin
                    state <= COUNT;
                    delay <= data;
                    count <= delay;
                end
                COUNT: begin
                    if (counter == duration) begin
                        if (delay == 0) begin
                            state <= DONE;
                        end else begin
                            delay <= delay - 1;
                            counter <= 0;
                        end
                    end else begin
                        counter <= counter + 1;
                    end
                end
                DONE: begin
                    if (ack == 1) begin
                        state <= IDLE;
                        count <= 4'b0;
                        counting <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
        end else begin
            case (state)
                COUNT: begin
                    counting <= 1;
                end
                DONE: begin
                    counting <= 0;
                end
                default: begin
                    counting <= 0;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else begin
            done <= (state == DONE) ? 1'b1 : 1'b0;
        end
    end
    
endmodule
