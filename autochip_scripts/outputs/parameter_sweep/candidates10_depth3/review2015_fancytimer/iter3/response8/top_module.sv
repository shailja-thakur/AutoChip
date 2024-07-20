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

    // State machine states
    localparam IDLE = 0;
    localparam START = 1;
    localparam SHIFT = 2;
    localparam COUNT = 3;
    localparam DONE = 4;

    // Initialize the outputs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0;
            counting <= 0;
            done <= 0;
        end else begin
            count <= delay;
            counting <= (state == COUNT);
            done <= (state == DONE);
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
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
                end
                SHIFT: begin
                    state <= COUNT;
                    delay <= data;
                    counter <= 0;
                end
                COUNT: begin
                    if (counter == (delay + 1) * 1000 - 1) begin
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
                    if (ack) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
