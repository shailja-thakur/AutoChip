module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] delay,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );


    reg [3:0] state;
    reg [3:0] next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay_counter;

    // Define the state values
    parameter IDLE = 4'b000;
    parameter DETECT_PATTERN = 4'b001;
    parameter SHIFT_IN_DELAY = 4'b010;
    parameter COUNTING = 4'b011;
    parameter WAIT_ACK = 4'b100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0000;
            delay_counter <= 4'b0000;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(state or data) begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state <= DETECT_PATTERN;
                end else begin
                    next_state <= IDLE;
                end
            end

            DETECT_PATTERN: begin
                next_state <= SHIFT_IN_DELAY;
            end

            SHIFT_IN_DELAY: begin
                shift_reg <= {shift_reg[2:0], data};
                delay <= shift_reg;
                next_state <= COUNTING;
            end

            COUNTING: begin
                counting <= 1;
                count <= delay_counter;
                delay_counter <= delay;
                if (delay_counter == 4'b0000) begin
                    next_state <= WAIT_ACK;
                end else begin
                    next_state <= COUNTING;
                end
            end

            WAIT_ACK: begin
                counting <= 0;
                done <= 1;
                if (ack) begin
                    next_state <= IDLE;
                end else begin
                    next_state <= WAIT_ACK;
                end
            end

            default: begin
                next_state <= IDLE;
            end
        endcase
    end

endmodule
