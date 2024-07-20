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
    reg [3:0] shift_count;
    reg [3:0] shift_latch;

    parameter IDLE    = 0;
    parameter DETECT  = 1;
    parameter SHIFT   = 2;
    parameter COUNT   = 3;
    parameter NOTIFY  = 4;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;

        case(state)
            IDLE: begin
                shift_ena = 0;
                counting = 0;
                done = 0;

                if (data == 4'b1101) begin
                    next_state = DETECT;
                    shift_count = 4'b0000;
                    shift_latch = data;
                end
            end

            DETECT: begin
                shift_ena = 0;
                counting = 0;
                done = 0;

                if (shift_latch == 4'b1101) begin
                    shift_count = shift_count + 1;
                end
                
                if (shift_count == 4'b0100) begin
                    next_state = SHIFT;
                    shift_count = 4'b0000;
                end else if (data != 4'b1101) begin
                    next_state = IDLE;
                end
            end

            SHIFT: begin
                shift_ena = 1;
                counting = 0;
                done = 0;

                if (shift_latch == 4'b1101) begin
                    shift_count = shift_count + 1;
                end
                
                if (shift_count == 4'b0100) begin
                    next_state = COUNT;
                    shift_count = 4'b0000;
                end else if (data != 4'b1101) begin
                    next_state = IDLE;
                end
            end

            COUNT: begin
                shift_ena = 0;
                counting = 1;
                done = 0;

                if (done_counting) begin
                    next_state = NOTIFY;
                end
            end

            NOTIFY: begin
                shift_ena = 0;
                counting = 0;
                done = 1;

                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
