module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
    );

    // State definitions
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter; // Assume 4-bit counter for simplicity, adjust as necessary

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == WAIT || state == PROCESS)
                counter <= counter + 1;
            else
                counter <= 4'b0000;
        end
    end

    // Next State Logic
    always_comb begin
        case (state)
            IDLE:
                next_state = WAIT;
            WAIT:
                next_state = (counter == 4'b1111) ? PROCESS : WAIT;
            PROCESS:
                next_state = DONE;
            DONE:
                next_state = IDLE;
            default:
                next_state = IDLE;
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'hAA; // Example data, can be changed as required
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
                default: begin
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
            endcase
        end
    end
endmodule
