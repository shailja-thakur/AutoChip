module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State declaration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;

    // Counter declaration
    reg [7:0] counter;

    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    counter <= 8'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    // Data processing logic
                    data_out <= 8'd255;  // Example data processing, replace with your logic
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (counter >= 8'd100) begin // Example threshold, replace with your logic
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
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

endmodule
