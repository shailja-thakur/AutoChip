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
    reg [3:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            state <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            4'b0000: begin
                if (data == 1'b1) begin
                    if (shift_ena == 1) begin
                        next_state = 4'b0001;
                    end else begin
                        next_state = 4'b0000;
                    end
                end else begin
                    next_state = 4'b0000;
                end
            end
            4'b0001: begin
                if (data == 1'b1) begin
                    if (shift_ena == 1) begin
                        next_state = 4'b0010;
                    end else begin
                        next_state = 4'b0000;
                    end
                end else begin
                    next_state = 4'b0000;
                end
            end
            4'b0010: begin
                if (data == 1'b0) begin
                    if (shift_ena == 1) begin
                        next_state = 4'b0011;
                    end else begin
                        next_state = 4'b0000;
                    end
                end else begin
                    next_state = 4'b0000;
                end
            end
            4'b0011: begin
                if (data == 1'b1) begin
                    if (shift_ena == 1) begin
                        next_state = 4'b0100;
                    end else begin
                        next_state = 4'b0000;
                    end
                end else begin
                    next_state = 4'b0000;
                end
            end
            4'b0100: begin
                next_state = 4'b0000;
            end
            default: begin
                next_state = 4'b0000;
            end
        endcase
    end

    always @(posedge clk) begin
        case (state)
            4'b0000: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
            4'b0001: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            4'b0010: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            4'b0011: begin
                shift_ena <= 1'b1;
                counting <= 1'b1;
                done <= 1'b0;
            end
            4'b0100: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            end
            default: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (done_counting == 1'b1 && ack == 1'b1) begin
            state <= 4'b0000;
        end
    end

endmodule
