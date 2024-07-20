module top_module(
    input wire clk,
    input wire rst,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;

    // State transitions
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM logic
    always @* begin
        // Default values
        next_state = state;
        counter = counter;
        data_out = 8'b0;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                counter = 4'b0;
                data_out = 8'b0;
                if (!rst)
                    next_state = WAIT;
            end

            WAIT: begin
                counter = counter + 1;
                if (counter == 4'b1111)
                    next_state = PROCESS;
            end

            PROCESS: begin
                data_out = 8'b10101010;  //Example processing data
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
