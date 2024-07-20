module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State declarations
    typedef enum {
        IDLE, WAIT, PROCESS, DONE
    } state_t;
    state_t state, next_state;

    // Counter
    reg [7:0] counter;

    // FSM sequential logic: State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else if (state == IDLE) begin
                counter <= 8'b0;
            end
        end
    end

    // FSM combinational logic: Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = IDLE;
        data_out = 8'b0;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                if (counter == 8'd10) begin // Example threshold
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end

            PROCESS: begin
                data_out = 8'hFF; // Example processed data
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
