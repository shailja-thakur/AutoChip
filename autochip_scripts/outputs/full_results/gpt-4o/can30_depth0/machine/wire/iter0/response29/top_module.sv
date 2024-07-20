module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State definitions
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    reg [1:0] state, next_state;
    reg [7:0] counter;
    reg [7:0] data_reg;

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    counter <= 0;
                    data_out <= 0;
                    valid_out <= 0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 0;
                    valid_out <= 0;
                end
                PROCESS: begin
                    data_out <= data_reg; // Assume data_reg is some data being processed
                end
                DONE: begin
                    valid_out <= 1;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end
            WAIT: begin
                if (counter >= 8) // Assuming the threshold is 8 clock cycles
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

endmodule
