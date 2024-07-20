module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Define state encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // Internal signals
    state_t state, next_state;
    reg [3:0] counter; // 4-bit counter to track clock cycles

    // FSM state transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;

            case (next_state)
                IDLE: begin
                    counter <= 4'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'd0;
                end
                PROCESS: begin
                    data_out <= 8'hAA; // Example processed data
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            IDLE: next_state = WAIT;
            WAIT: next_state = (counter == 4'd10) ? PROCESS : WAIT;
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
