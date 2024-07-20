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

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        delay <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Searching for start sequence
                if (data == 4'b1101) begin
                    delay <= data;
                    counting <= 1;
                    state <= 1;
                end
            end
            1: begin // Shifting in the delay value
                delay <= data;
                counting <= 0;
                state <= 2;
            end
            2: begin // Counting
                counting <= 1;
                if (count >= (delay + 1) * 1000) begin
                    state <= 3;
                end
            end
            3: begin // Done counting, waiting for ack
                counting <= 0;
                done <= 1;
                if (ack) begin
                    state <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = counting ? (delay - (count / 1000)) : 4'bxxxx;

endmodule
