module top_module(
    input clock,
    input reset,
    output reg [31:0] data_out,
    output reg valid_out
);
    
    // State encoding
    parameter [1:0] IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11;

    reg [1:0] state, next_state;
    reg [31:0] counter;

    // State transition
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic & output logic
    always @(*) begin
        next_state = state;
        data_out = 0;
        valid_out = 0;

        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = WAIT;
                    counter = 0;
                    data_out = 0;
                end
            end

            WAIT: begin
                counter = counter + 1;
                if (counter == 32'h1000) begin
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end

            PROCESS: begin
                data_out = 32'hDEADBEEF; // Example data processing
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1;
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
