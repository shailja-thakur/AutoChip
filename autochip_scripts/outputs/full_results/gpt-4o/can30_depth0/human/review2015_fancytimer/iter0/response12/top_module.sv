module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] state;
    reg [3:0] delay;
    reg [15:0] timer;  // To count up to 15000 cycles (4 bit delay + 1) * 1000
    
    localparam IDLE      = 4'd0,
               PATTERN   = 4'd1,
               SHIFT1    = 4'd2,
               SHIFT2    = 4'd3,
               SHIFT3    = 4'd4,
               SHIFT4    = 4'd5,
               COUNTING  = 4'd6,
               DONE      = 4'd7;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'd0;
            timer <= 16'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data == 1'b1) // Start looking for 1101
                        state <= PATTERN;
                end
                PATTERN: begin
                    if (data == 1'b1 && state == 4'b0001)
                        state <= SHIFT1;
                    else
                        state <= IDLE;
                end
                SHIFT1: begin
                    delay[3] <= data;
                    state <= SHIFT2;
                end
                SHIFT2: begin
                    delay[2] <= data;
                    state <= SHIFT3;
                end
                SHIFT3: begin
                    delay[1] <= data;
                    state <= SHIFT4;
                end
                SHIFT4: begin
                    delay[0] <= data;
                    state <= COUNTING;
                    timer <= (delay + 1) * 1000;
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (timer > 0) begin
                        timer <= timer - 1;
                        if (timer % 1000 == 0)
                            count <= (timer / 1000) - 1;
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= DONE;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= IDLE;
                        done <= 1'b0;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
