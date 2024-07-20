module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] timer_count;
    reg [3:0] remaining_time;
    reg [3:0] shift_register;
    reg [3:0] state;
    reg start_sequence_detected;

    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            timer_count <= 0;
            remaining_time <= 0;
            shift_register <= 0;
            state <= 0;
            start_sequence_detected <= 0;
        end else begin
            if (start_sequence_detected) begin
                if (timer_count < ((delay + 1) * 1000)) begin
                    counting <= 1;
                end else begin
                    counting <= 0;
                    done <= 1;
                end
            end else begin
                counting <= 0;
                done <= 0;
            end

            if (state == 0) begin
                if (data == 1 && shift_register == 6'b1101) begin
                    state <= 1;
                    start_sequence_detected <= 1;
                    delay <= shift_register[3:0];
                    timer_count <= 0;
                    remaining_time <= delay;
                end
            end else if (state == 1) begin
                state <= 2;
            end else if (state == 2) begin
                shift_register <= 6'b0000;
                state <= 3;
            end else if (state == 3) begin
                if (timer_count < ((delay + 1) * 1000)) begin
                    timer_count <= timer_count + 1;
                    if (timer_count % 1000 == 0) begin
                        remaining_time <= remaining_time - 1;
                    end
                end else begin
                    state <= 0;
                    start_sequence_detected <= 0;
                end
            end
        end
    end

    assign count = counting ? remaining_time : 4'bxxxx;

endmodule
