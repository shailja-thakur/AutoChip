module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State Declaration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Counter Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
        end else if (state == WAIT) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
        end
    end

    // Next State Logic and Output Logic
    always @(*) begin
        next_state = state;
        data_out = 8'b0;
        valid_out = 0;

        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                    counter = 0;
                    data_out = 8'b0;
                    valid_out = 0;
                end else begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                data_out = 8'b0;
                if (counter == 4'b1111) begin
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end

            PROCESS: begin
                data_out = 8'hFF; // Assign some data
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1;
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
