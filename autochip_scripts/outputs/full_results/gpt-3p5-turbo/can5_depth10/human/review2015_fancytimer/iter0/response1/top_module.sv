module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [3:0] remaining_time;
    reg [3:0] shift_reg;
    reg start_sequence;
    reg start_sequence_detected;
    reg counting_delay;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'b0000;
            count_reg <= 4'b0000;
            remaining_time <= 4'b0000;
            shift_reg <= 4'b0000;
            start_sequence <= 1'b0;
            start_sequence_detected <= 1'b0;
            counting_delay <= 1'b0;
            counting <= counting_delay;
            done <= 1'b0;
        end else begin
            if (start_sequence_detected && !counting_delay) begin
                count_reg <= delay;
                counting_delay <= 1'b1;
            end else begin
                count_reg <= count_reg - 1;
                counting_delay <= count_reg != 0;
                done <= count_reg == 0 && ack;
            end

            if (data == 1'b1) begin
                shift_reg <= {shift_reg[2:0], data};
            end
            
            if (shift_reg == 4'b1101 && !start_sequence_detected) begin
                start_sequence <= 1'b1;
                start_sequence_detected <= 1'b1;
                delay <= shift_reg;
                shift_reg <= 4'b0000;
            end else begin
                start_sequence <= 1'b0;
                start_sequence_detected <= 1'b0;
            end

            remaining_time <= count_reg;
        end
    end
    
    assign count = counting_delay ? remaining_time : 4'bxxxx;
endmodule
