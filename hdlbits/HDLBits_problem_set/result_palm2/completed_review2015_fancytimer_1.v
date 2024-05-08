module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    // State machine
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            switch (state) begin
                case (IDLE) begin
                    if (data == 1101) begin
                        state <= SHIFT_DELAY;
                    end
                end
                case (SHIFT_DELAY) begin
                    if (data == 1101) begin
                        count <= 4'b0000;
                        state <= COUNTING;
                    end else begin
                        count <= count + 1;
                    end
                end
                case (COUNTING) begin
                    if (count == 5'b1111) begin
                        state <= DONE;
                    end
                end
                case (DONE) begin
                    if (ack) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    // Counter
    always @(posedge clk) begin
        if (state == COUNTING) begin
            count <= count + 1;
        end
    end

    // Counting output
    assign counting = state == COUNTING;

    // Done output
    assign done = state == DONE;

endmodule