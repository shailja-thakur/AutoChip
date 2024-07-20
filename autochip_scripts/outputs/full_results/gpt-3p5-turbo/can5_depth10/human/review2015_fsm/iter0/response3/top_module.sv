module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

reg [3:0] state;
wire pattern_detected;

assign pattern_detected = (data == 4'b1101);

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin
                if (pattern_detected) begin
                    state <= 1;
                    shift_ena <= 1;
                end
                else begin
                    state <= 0;
                    shift_ena <= 0;
                end
            end
            1: begin
                state <= 2;
                shift_ena <= 0;
            end
            2: begin
                state <= 3;
                counting <= 1;
            end
            3: begin
                if (done_counting) begin
                    state <= 4;
                    done <= 1;
                end
                else begin
                    state <= 3;
                    done <= 0;
                end
            end
            4: begin
                if (ack) begin
                    state <= 0;
                    done <= 0;
                end
                else begin
                    state <= 4;
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
