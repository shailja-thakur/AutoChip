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
reg [3:0] timer;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        delay <= 4'b0000;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            3'b000: begin
                if (data == 1'b1) begin
                    state <= 3'b001;
                end
            end
            3'b001: begin
                if (data == 1'b1) begin
                    state <= 3'b010;
                    delay[3] <= data;
                end else begin
                    state <= 3'b000;
                end
            end
            3'b010: begin
                if (data == 1'b1) begin
                    delay[2] <= data;
                    state <= 3'b011;
                end else begin
                    delay <= 4'b0000;
                    state <= 3'b000;
                end
            end
            3'b011: begin
                if (data == 1'b1) begin
                    delay[1] <= data;
                    state <= 3'b100;
                end else begin
                    delay <= 4'b0000;
                    state <= 3'b000;
                end
            end
            3'b100: begin
                if (data == 1'b1) begin
                    delay[0] <= data;
                    counting <= 1;
                    state <= 3'b101;
                end else begin
                    delay <= 4'b0000;
                    state <= 3'b000;
                end
            end
            3'b101: begin
                if (timer < (delay + 1) * 1000) begin
                    timer <= timer + 1;
                end else begin
                    counting <= 0;
                    done <= 1;
                    state <= 3'b110;
                end
            end
            3'b110: begin
                if (ack == 1'b1) begin
                    delay <= 4'b0000;
                    state <= 3'b000;
                    done <= 0;
                end
            end
        endcase
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        timer <= 4'b0000;
    end
end

assign count = counting ? delay - (timer / 1000) : 4'bzzzz;

endmodule
