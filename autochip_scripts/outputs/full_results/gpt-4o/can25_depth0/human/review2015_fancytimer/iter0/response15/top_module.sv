module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum logic [2:0] {
        IDLE,
        SEARCH,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay_reg;
    reg [13:0] cycle_counter; // Enough to count up to 16000 cycles (15 bits > log2(16000))
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                done = 0;
                counting = 0;
                shift_reg = 4'b0000;
                cycle_counter = 14'b0;
                if (reset)
                    next_state = SEARCH;
            end
            SEARCH: begin
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
                else begin
                    shift_reg = {shift_reg[2:0], data};
                end
            end
            LOAD_DELAY: begin
                if (shift_reg == 4'b1101) begin
                    delay_reg = {delay_reg[2:0], data};
                    if (delay_reg[3]) begin
                        next_state = COUNTING;
                    end
                end
                else begin
                    shift_reg = {shift_reg[2:0], data};
                end
            end
            COUNTING: begin
                if (cycle_counter == (delay_reg + 1) * 1000) begin
                    next_state = WAIT_ACK;
                end
                else begin
                    cycle_counter = cycle_counter + 1;
                    counting = 1;
                end
            end
            WAIT_ACK: begin
                done = 1;
                if (ack) begin
                    next_state = SEARCH;
                end
            end
        endcase
    end

    reg [3:0] count_reg;
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count_reg <= 0;
        end
        else if (counting) begin
            count_reg <= delay_reg - (cycle_counter / 1000);
        end
    end

    assign count = counting ? count_reg : 4'bxxxx;

endmodule
