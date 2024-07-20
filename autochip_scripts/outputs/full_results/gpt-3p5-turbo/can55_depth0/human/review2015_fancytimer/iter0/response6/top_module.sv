module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] timer;
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 4'b1101) begin
                        state <= 1;
                        timer <= 0;
                    end
                end
                1: begin
                    state <= 2;
                    counting <= 1;
                    delay <= data;
                    timer <= delay;
                end
                2: begin
                    if (timer > 0) begin
                        timer <= timer - 1;
                    end else begin
                        state <= 3;
                        counting <= 0;
                        done <= 1;
                    end
                end
                3: begin
                    if (ack == 1) begin
                        state <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'bxxxx;
        end else begin
            case (state)
                0: begin
                    count <= 4'bxxxx;
                end
                1: begin
                    count <= delay;
                end
                2: begin
                    count <= timer;
                end
                3: begin
                    count <= 4'bxxxx;
                end
            endcase
        end
    end

endmodule
