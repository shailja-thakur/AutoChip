module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [7:0] shift_data;
    reg [3:0] delay;

    // State definitions
    localparam STATE_IDLE = 2'b00;
    localparam STATE_START = 2'b01;
    localparam STATE_COUNT = 2'b10;

    // State register
    reg [1:0] state_reg;
    always @(posedge clk or posedge reset) begin
        if (reset)
            state_reg <= STATE_IDLE;
        else
            state_reg <= next_state;
    end

    // Next state logic
    reg [1:0] next_state;
    always @* begin
        case (state_reg)
            STATE_IDLE:
                begin
                    if (data == 4'b1101)
                        next_state = STATE_START;
                    else
                        next_state = STATE_IDLE;
                end

            STATE_START:
                begin
                    shift_data <= data;
                    next_state = STATE_COUNT;
                end

            STATE_COUNT:
                begin
                    if (counting)
                        next_state = STATE_COUNT;
                    else
                        next_state = STATE_IDLE;
                end

            default: next_state = STATE_IDLE;
        endcase
    end

    // Count register
    reg [9:0] count_reg;

    always @(posedge clk or posedge reset) begin
        if (reset)
            count_reg <= 0;
        else if (state_reg == STATE_COUNT && counting)
            count_reg <= count_reg + 1;
    end

    // Counting logic
    always @* begin
        if (state_reg == STATE_COUNT && counting)
            counting = 1;
        else
            counting = 0;
    end

    // Done logic
    always @* begin
        if (count_reg == (delay + 1) * 1000)
            done = 1;
        else
            done = 0;
    end

    // Remaining time logic
    wire [3:0] remaining_time;
    assign remaining_time = delay - (count_reg / 1000);

    // Output assignments
    assign count = count_reg[3:0];
    assign delay = shift_data[3:0];

    // Acknowledge and reset logic
    always @(posedge clk) begin
        if (state_reg == STATE_IDLE && ack)
            reset <= 1;
        else
            reset <= 0;
    end
endmodule
