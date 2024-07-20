module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] current_count;
    reg [3:0] remaining_time;
    reg [3:0] next_delay;

    reg [3:0] shift_reg;
    reg [3:0] compare;
    reg [3:0] start_sequence;
    
    wire start_detected;

    // Detect start sequence
    always @(posedge clk) begin
        if (reset) begin
            start_sequence <= 4'b1101;
            shift_reg <= 4'b0;
            compare <= 4'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else if (data == 1'b1) begin
            shift_reg <= {shift_reg[2:0], data};
            compare <= {shift_reg[1:0], data};
            if (compare == start_sequence) begin
                start_detected <= 1'b1;
                delay <= next_delay;
                counting <= 1'b1;
                current_count <= 4'b0;
                remaining_time <= delay;
            end else begin
                start_detected <= 1'b0;
            end
        end else begin
            start_detected <= 1'b0;
        end
    end

    // Counting logic
    always @(posedge clk) begin
        if (reset) begin
            current_count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else if (counting) begin
            if (current_count == (delay + 1)) begin
                counting <= 1'b0;
                done <= 1'b1;
            end else begin
                current_count <= current_count + 1;
                if (current_count == 4'b0000 && remaining_time != 4'b0000) begin
                    remaining_time <= remaining_time - 1;
                end
            end
        end
    end

    // Shift in delay value
    always @(posedge clk) begin
        if (start_detected) begin
            next_delay <= {shift_reg[3], shift_reg[2]};
        end
    end

    assign count = counting ? remaining_time : 4'bzzzz;

endmodule
