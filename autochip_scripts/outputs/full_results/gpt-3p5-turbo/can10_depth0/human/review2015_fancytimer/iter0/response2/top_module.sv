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
    reg start_sequence_detected;
    reg counting_done;
    
    parameter COUNT_DURATION = 1000;
    parameter START_SEQUENCE = 4'b1101;
    
    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'b0;
            count_reg <= 4'b0;
            remaining_time <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            start_sequence_detected <= 1'b0;
            counting_done <= 1'b0;
        end else begin
            if (start_sequence_detected && !counting && !counting_done) begin
                if (count_reg == delay) begin
                    counting <= 1'b1;
                end
            end else if (counting && remaining_time > 4'b0) begin
                remaining_time <= remaining_time - 4'b1;
            end else if (counting && remaining_time == 4'b0) begin
                counting <= 1'b0;
                done <= 1'b1;
                counting_done <= 1'b1;
            end else if (!start_sequence_detected && counting_done && ack) begin
                counting_done <= 1'b0;
            end
            
            if (!start_sequence_detected && data == START_SEQUENCE) begin
                start_sequence_detected <= 1'b1;
                delay <= {data[7:4]};
                count_reg <= {delay};
                remaining_time <= {delay};
            end
        end
    end
    
    assign count = count_reg;
    
endmodule
