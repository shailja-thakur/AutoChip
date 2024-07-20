module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);
    // States definition
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = WAIT;
                else
                    next_state = IDLE;
            end
            WAIT: begin
                if (counter >= 8'd100)  // Example threshold
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // State outputs and counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 8'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1'b1;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= counter; // Example processing logic
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
                default: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end
            endcase
        end
    end
endmodule
