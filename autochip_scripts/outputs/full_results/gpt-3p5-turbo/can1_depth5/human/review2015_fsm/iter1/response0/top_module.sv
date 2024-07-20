module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define the states
    typedef enum logic [2:0] {
        SEARCH,
        SHIFT_ENA,
        WAIT_COUNTING,
        DONE,
        RESET_STATE
    } state_type;

    // Define the state register
    reg [2:0] state;

    // Define the next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RESET_STATE;
        end else begin
            case (state)
                SEARCH: begin
                    if (data == 4'b1101) begin
                        state <= SHIFT_ENA;
                    end else begin
                        state <= SEARCH;
                    end
                end
                SHIFT_ENA: begin
                    state <= WAIT_COUNTING;
                end
                WAIT_COUNTING: begin
                    if (done_counting) begin
                        state <= DONE;
                    end else begin
                        state <= WAIT_COUNTING;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= SEARCH;
                    end else begin
                        state <= DONE;
                    end
                end
                RESET_STATE: begin
                    state <= SEARCH;
                end
                default: begin
                    state <= SEARCH;
                end
            endcase
        end
    end

    // Define the output logic
    always @(posedge clk) begin
        case (state)
            SEARCH: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT_ENA: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            WAIT_COUNTING: begin
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            DONE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
            default: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end

endmodule
