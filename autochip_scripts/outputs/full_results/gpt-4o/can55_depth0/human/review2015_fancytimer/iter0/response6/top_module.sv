module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] shift_reg;
    reg [2:0] state, next_state;
    reg [3:0] delay;
    reg [12:0] counter; 

    localparam IDLE = 3'd0,
               DETECT_PATTERN = 3'd1,
               SHIFT_IN_DELAY = 3'd2,
               COUNTING = 3'd3,
               DONE = 3'd4;

    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
            shift_reg <= 4'b0;
            count <= 4'b0;
            delay <= 4'b0;
            counter <= 13'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DETECT_PATTERN || state == SHIFT_IN_DELAY) begin
                shift_reg <= {shift_reg[2:0], data};
            end
        end
    end

    always @(*) begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = SHIFT_IN_DELAY;
                end
            end
            DETECT_PATTERN: begin
                if (shift_reg == 4'b1101) begin
                    next_state = SHIFT_IN_DELAY;
                end
            end
            SHIFT_IN_DELAY: begin
                if (shift_reg == 4'b1101) begin
                    delay = shift_reg[3:0];
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                if (counter < (delay + 1) * 1000) begin
                    counting = 1'b1;
                    count = counter / 1000;
                end else begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if (state == COUNTING) begin
            counter <= counter + 1;
        end else begin
            counter <= 13'b0;
        end
    end
endmodule
