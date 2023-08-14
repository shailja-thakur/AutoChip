module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    // The state machine
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
                    if (data == 1101) begin
                        count <= 4'b0000;
                        state <= COUNT;
                    end else begin
                        count <= count + 1;
                    end
                end
                COUNT: begin
                    if (count == 5'b0000) begin
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

    // The counter
    always @(posedge clk or negedge reset) begin
        if (reset) begin
            count <= 4'b0000;
        end else begin
            case (state)
                SHIFT_DELAY: begin
                    count <= count + 1;
                end
                COUNT: begin
                    count <= count + 1;
                end
            endcase
        end
    end

    // The output signals
    output [3:0] count;
    output counting;
    output done;

    assign counting = (state == COUNT);
    assign done = (state == DONE);
endmodule