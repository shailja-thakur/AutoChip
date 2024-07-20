module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [2:0] state;
    reg start_detected;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            delay <= 4'b0000;
            counting <= 0;
            done <= 0;
            start_detected <= 0;
        end else begin
            case (state)
                3'b000: begin
                    if (data == 1 && !$past(data)) begin
                        state <= 3'b001;
                        start_detected <= 1;
                    end
                end
                3'b001: begin
                    delay[3] <= data;
                    state <= 3'b010;
                end
                3'b010: begin
                    delay[2] <= data;
                    state <= 3'b011;
                end
                3'b011: begin
                    delay[1] <= data;
                    state <= 3'b100;
                end
                3'b100: begin
                    delay[0] <= data;
                    state <= 3'b101;
                end
                3'b101: begin
                    counting <= 1;
                    state <= 3'b110;
                end
                3'b110: begin
                    if (count >= ((delay + 1) * 1000)) begin
                        counting <= 0;
                        done <= 1;
                    end
                    else if (count < ((delay + 1) * 1000)) begin
                        counting <= 1;
                    end
                    state <= 3'b111;
                end
                3'b111: begin
                    if (ack) begin
                        state <= 3'b000;
                        done <= 0;
                        start_detected <= 0;
                    end
                end
            endcase
        end
    end

    assign count = counting ? delay : 4'bxxxx;

endmodule
