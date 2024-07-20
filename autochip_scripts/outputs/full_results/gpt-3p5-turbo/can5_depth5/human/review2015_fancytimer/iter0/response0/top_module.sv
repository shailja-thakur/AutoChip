module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    /*
     * Internal signals
     */
    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg start_sequence_detected;
    reg [3:0] state;
    wire seq_detected;
    wire [3:0] shift_data;

    /*
     * Sequential logic
     */
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            remaining_time <= 0;
            start_sequence_detected <= 0;
            delay <= 0;
            state <= 0;
        end else begin
            if (start_sequence_detected && counting) begin
                if (remaining_time == 0) begin
                    counting <= 0;
                    done <= 1;
                end else begin
                    counting <= 1;
                    remaining_time <= remaining_time - 1;
                end
            end else if (start_sequence_detected && !counting) begin
                counting <= 1;
                remaining_time <= delay;
                done <= 0;
            end else if (!start_sequence_detected && counting) begin
                counting <= 0;
                done <= 0;
                remaining_time <= 0;
                state <= 0;
            end else begin
                counting <= 0;
                done <= 0;
                remaining_time <= 0;
                if (seq_detected) begin
                    start_sequence_detected <= 1;
                    delay <= shift_data;
                    state <= 0;
                end else begin
                    start_sequence_detected <= 0;
                    delay <= 0;
                    state <= 0;
                end
            end
        end
    end

    /*
     * Combinational logic
     */
    assign count = counting ? remaining_time : 4'bxxxx;
    assign seq_detected = (state == 4'b1101);
    assign shift_data = data;

endmodule
