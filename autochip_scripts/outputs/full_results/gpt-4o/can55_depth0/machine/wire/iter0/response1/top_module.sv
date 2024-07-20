module top_module (
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11} state_t;
    state_t state, next_state;

    // Internal signals
    reg [7:0] counter;

    // State transition logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = (reset) ? IDLE : WAIT;
            end
            WAIT: begin
                next_state = (counter == 8'hFF) ? PROCESS : WAIT;
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

    // Output logic and counter logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 8'h00;
            data_out <= 8'h00;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'h00;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1'b1;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'hAA; // Example data, adapt as needed
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

endmodule
