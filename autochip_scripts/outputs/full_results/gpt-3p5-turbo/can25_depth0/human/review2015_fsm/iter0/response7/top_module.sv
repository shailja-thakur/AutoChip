module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [1:0] state;
    reg [3:0] detect_count;
    reg pattern_detected;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            detect_count <= 4'b0000;
            pattern_detected <= 1'b0;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case(state)
                2'b00: begin
                    if (data == 1'b1)
                        detect_count <= detect_count + 1'b1;
                    else
                        detect_count <= 4'b0000;

                    if (detect_count == 4'b1101)
                        pattern_detected <= 1'b1;
                    else
                        pattern_detected <= 1'b0;

                    if (pattern_detected)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end

                2'b01: begin
                    shift_ena <= 1'b1;
                    state <= 2'b10;
                end

                2'b10: begin
                    counting <= 1'b1;

                    if (done_counting)
                        state <= 2'b11;
                    else
                        state <= 2'b10;
                end

                2'b11: begin
                    done <= 1'b1;

                    if (ack)
                        state <= 2'b00;
                    else
                        state <= 2'b11;
                end
            endcase
        end
    end
endmodule
