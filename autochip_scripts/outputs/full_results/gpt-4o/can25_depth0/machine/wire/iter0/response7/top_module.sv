module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // States of the FSM
    typedef enum {
        IDLE,
        WAIT,
        PROCESS,
        DONE
    } fsm_state_t;

    fsm_state_t state = IDLE;
    reg [3:0] counter;

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'b0;
                    data_out <= 8'b0;
                    state <= WAIT;
                end

                WAIT: begin
                    if (counter < 4'b1000) begin
                        counter <= counter + 1;
                        data_out <= 8'b0;
                    end else begin
                        state <= PROCESS;
                    end
                end

                PROCESS: begin
                    data_out <= 8'b10101010; // Example processed data
                    state <= DONE;
                end

                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
