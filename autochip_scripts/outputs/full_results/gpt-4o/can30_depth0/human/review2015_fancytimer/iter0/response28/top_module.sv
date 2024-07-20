module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [2:0] state, next_state;
    reg [3:0] delay, delay_count;
    reg [12:0] cycle_count; // for counting up to (delay+1) * 1000 cycles
    reg [3:0] data_shift;

    localparam S_IDLE = 3'd0,
               S_DETECT = 3'd1,
               S_SHIFT = 3'd2,
               S_COUNT = 3'd3,
               S_DONE = 3'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            delay <= 4'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            delay_count <= 4'b0;
            cycle_count <= 13'b0;
            data_shift <= 4'b0;
        end else begin
            state <= next_state;
            if (state == S_IDLE) begin
                count <= 4'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end else if (state == S_DETECT || state == S_SHIFT) begin
                // Capture the input data shift
                data_shift <= {data_shift[2:0], data};
            end else if (state == S_SHIFT) begin
                // Shift in delay bits
                delay <= {delay[2:0], data};
                if (delay_count == 4'b1000) // All 4 delay bits shifted in
                    delay_count <= 4'b0;
                else
                    delay_count <= delay_count + 1;
            end else if (state == S_COUNT) begin
                // Counting state
                counting <= 1'b1;
                if (cycle_count < 999) begin
                    cycle_count <= cycle_count + 1;
                end else if (count != 0) begin
                    cycle_count <= 0;
                    count <= count - 1;
                end else begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            
            if (ack) begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                // Looking for the start sequence 1101
                if (reset) next_state = S_IDLE;
                else if (data_shift == 4'b1101) next_state = S_SHIFT;
            end
            S_DETECT: begin
                if (data_shift == 4'b1101) next_state = S_SHIFT;
            end
            S_SHIFT: begin
                if (delay_count == 4'b0111) next_state = S_COUNT;
            end
            S_COUNT: begin
                if (!counting && done) next_state = S_DONE;
            end
            S_DONE: begin
                if (ack) next_state = S_IDLE;
            end
        endcase
    end

    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count <= 13'b0;
            count <= 4'b0;
        end else if (state == S_SHIFT) begin
            if (delay_count == 4'b0111) begin
                // Adjust for (delay+1) * 1000 cycles
                count <= delay[3:0];
                cycle_count <= 13'b0;
            end
        end
    end

endmodule
