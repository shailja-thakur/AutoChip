module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    // FSM state machine
    always @(posedge clk or negedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1101) begin
                        state <= SHIFT_DELAY;
                    end
                end
                SHIFT_DELAY: begin
                    if (data == 1000) begin
                        state <= COUNT;
                    end
                end
                COUNT: begin
                    count <= count + 1;
                    if (count == (delay[3:0] + 1)) begin
                        state <= DONE;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    // Counter
    always @(posedge clk) begin
        if (state == COUNT) begin
            count <= count + 1;
        end
    end

    // Counting output
    always @(posedge clk) begin
        if (state == COUNT) begin
            counting <= 1;
        end else begin
            counting <= 0;
        end
    end

    // Done output
    always @(posedge clk) begin
        if (state == DONE) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule