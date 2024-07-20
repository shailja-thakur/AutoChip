module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Declare states
    parameter IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11;
    reg [1:0] state, next_state;
    reg [3:0] counter; // 4-bit counter

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 1;
            else
                counter <= 0;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = WAIT;
            WAIT: next_state = (counter == 4'b1111) ? PROCESS : WAIT; // threshold set to 15
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'b10101010; // some example data
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end
endmodule
