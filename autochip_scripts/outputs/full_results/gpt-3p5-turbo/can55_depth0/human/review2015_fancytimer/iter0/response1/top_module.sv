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
    reg [3:0] remaining_time;
    reg [3:0] next_state;
    reg [3:0] current_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= 4'b0000;
            remaining_time <= 4'b0000;
            done <= 1'b0;
            counting <= 1'b0;
        end
        else begin
            current_state <= next_state;
            remaining_time <= remaining_time + 1'b1;
            done <= 1'b0;
            counting <= 1'b1;
        end
    end

    always @(current_state, data) begin
        case (current_state)
            4'b0000: begin
                if (data == 1'b1)
                    next_state <= 4'b0001;
                else
                    next_state <= 4'b0000;
            end
            4'b0001: begin
                if (data == 1'b1)
                    next_state <= 4'b0010;
                else
                    next_state <= 4'b0000;
            end
            4'b0010: begin
                if (data == 1'b1)
                    next_state <= 4'b0011;
                else
                    next_state <= 4'b0000;
            end
            4'b0011: begin
                if (data == 1'b1)
                    next_state <= 4'b0100;
                else
                    next_state <= 4'b0000;
            end
            4'b0100: begin
                if (data == 1'b1) begin
                    delay <= data;
                    next_state <= 4'b0101;
                end
                else
                    next_state <= 4'b0000;
            end
            4'b0101: begin
                timer <= delay;
                next_state <= 4'b0110;
            end
            4'b0110: begin
                if (remaining_time == (timer + 1'b1) * 4'b1000) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    next_state <= 4'b0111;
                end
                else
                    next_state <= 4'b0110;
            end
            4'b0111: begin
                if (ack == 1'b1)
                    next_state <= 4'b0000;
                else
                    next_state <= 4'b0111;
            end
            default: next_state <= 4'b0000;
        endcase
    end

    assign count = remaining_time;

endmodule
