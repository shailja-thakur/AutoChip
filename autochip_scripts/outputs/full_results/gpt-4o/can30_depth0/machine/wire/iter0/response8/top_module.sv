module top_module(
    input  clk,
    input  rst,
    output reg [7:0] data_out,
    output reg valid_out
);

    // FSM states
    typedef enum reg [1:0] {IDLE, WAIT, PROCESS, DONE} state_t;
    state_t state, next_state;

    // Internal signals
    reg [7:0] counter;

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (rst) next_state = IDLE;
                else next_state = WAIT;
            end

            WAIT: begin
                if (counter == 8'd255) next_state = PROCESS;
                else next_state = WAIT;
            end

            PROCESS: begin
                next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // State transition and output logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            case (next_state)
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
                    data_out <= // your data processing logic here, e.g., a certain value or computation
                    valid_out <= 1'b0;
                end

                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

endmodule
