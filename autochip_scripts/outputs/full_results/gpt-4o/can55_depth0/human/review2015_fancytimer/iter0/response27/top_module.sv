module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [2:0] state, next_state;
    reg [3:0] delay, next_delay;
    reg [12:0] counter, next_counter;
    reg [3:0] search;
    
    parameter S_IDLE = 3'b000;
    parameter S_SEARCH = 3'b001;
    parameter S_LOAD_DELAY = 3'b010;
    parameter S_COUNT = 3'b011;
    parameter S_DONE = 3'b100;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            delay <= 0;
            counter <= 0;
            search <= 4'b0000;
        end else begin
            state <= next_state;
            delay <= next_delay;
            counter <= next_counter;
            search <= {search[2:0], data};
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        next_delay = delay;
        next_counter = counter;
        case (state)
            S_IDLE: begin
                done = 0;
                counting = 0;
                count = 4'bxxxx;
                if (search == 4'b1101) begin
                    next_state = S_LOAD_DELAY;
                    next_counter = 0;
                end else begin
                    next_state = S_SEARCH;
                end
            end
            S_SEARCH: begin
                if (search == 4'b1101) begin
                    next_state = S_LOAD_DELAY;
                    next_counter = 0;
                end
            end
            S_LOAD_DELAY: begin
                if (counter < 4) begin
                    next_counter = counter + 1;
                    next_delay = {delay[2:0], data};
                end else begin
                    next_state = S_COUNT;
                    next_counter = (delay + 1) * 1000;
                end
            end
            S_COUNT: begin
                counting = 1;
                count = next_counter / 1000;
                if (counter > 0) begin
                    next_counter = counter - 1;
                end else begin
                    next_state = S_DONE;
                end
            end
            S_DONE: begin
                counting = 0;
                done = 1;
                if (ack == 1) begin
                    next_state = S_IDLE;
                end
            end
        endcase
    end

endmodule
