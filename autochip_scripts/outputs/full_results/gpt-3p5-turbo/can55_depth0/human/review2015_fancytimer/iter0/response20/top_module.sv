module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg start_sequence_detected;
    reg [3:0] delay;
    reg [11:0] counter;
    reg [1:0] state;
    wire start_sequence_detected_next;
    wire [3:0] delay_next;
    wire [11:0] counter_next;
    wire [1:0] state_next;

    assign start_sequence_detected_next = (state == 0 /* idle */ && data == 1 && $past(data, 1) == 1 && $past(data, 2) == 0 && $past(data, 3) == 1) || (state != 0 /* idle */);
    assign delay_next = state == 4 ? data : delay;
    assign counter_next = state == 4 ? (delay + 1) * 1000 : counter;
    assign state_next = state == 4 && counter_next == 0 ? 0 /* idle */ : (state == 4 ? 3 /* counting */ : (start_sequence_detected_next ? 1 /* detecting */ : state));

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            done <= 0;
            counting <= 0;
            state <= 0;
            start_sequence_detected <= 0;
            delay <= 0;
        end else begin
            counter <= counter_next;
            done <= state == 0 /* idle */ && counter == 0;
            counting <= state == 3 /* counting */;
            state <= state_next;
            start_sequence_detected <= start_sequence_detected_next;
            delay <= delay_next;
        end
    end

    assign count = counting ? delay : 4'bxxxx;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            done <= 0;
            counting <= 0;
            start_sequence_detected <= 0;
            delay <= 0;
        end else begin
            if (state == 3 /* counting */) begin
                counter <= counter - 1;
            end
        end
    end

endmodule
