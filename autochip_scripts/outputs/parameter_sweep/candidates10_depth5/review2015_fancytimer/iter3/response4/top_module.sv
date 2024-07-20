module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
  
    parameter IDLE = 2'b00;
    parameter DETECTED = 2'b01;
    parameter COUNTING = 2'b10;
    parameter DONE = 2'b11;

    reg [2:0] state;
    reg [3:0] delay;
    reg [15:0] counter;
    reg flag;
    reg [3:0] remaining_time;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 0;
            counter <= 0;
            counting <= 0;
            done <= 0;
            flag <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1 && flag) begin
                        state <= DETECTED;
                        counting <= 1;
                    end else if (data == 1) begin
                        flag <= 1;
                    end
                end
                DETECTED: begin
                    delay <= {data, delay[3:1]};
                    state <= COUNTING;
                    counter <= 0;
                    remaining_time <= delay;
                end
                COUNTING: begin
                    if (counter == ((delay + 1) * 1000)) begin
                        counting <= 0;
                        done <= 1;
                        state <= DONE;
                    end else begin
                        counter <= counter + 1;
                        if (counter % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                    end
                end
                DONE: begin
                    if (ack == 1) begin
                        done <= 0;
                        flag <= 0;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bx;

endmodule
