module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // FSM logic
    always @(*) begin
        next_state = state; // Default stay in the same state
        case (state)
            IDLE: begin
                if (reset)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end
            WAIT: begin
                if (counter == 4'd10)
                    next_state = PROCESS;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic and counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'd255; // Example processed data
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

endmodule
