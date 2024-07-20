module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out, // assuming 8-bit data output
    output reg valid_out
);

    //State Encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter; // assuming 4-bit counter for counting clock cycles; adjust as needed
    reg [7:0] data; // internal data register; adjust width as needed

    // FSM sequential logic for state transition
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else begin
                counter <= 4'b0000;
            end
        end
    end

    // FSM combinational logic for next state and outputs
    always @(*) begin
        // Default values
        next_state = state;
        data_out = 8'b00000000;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                    data_out = 8'b00000000;
                end else begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                data_out = 8'b00000000;
                if (counter == 4'b1111) // assuming threshold is 15 clock cycles; adjust as needed
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end

            PROCESS: begin
                data_out = data; // Output the processed data
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1'b1; // Data is valid
                next_state = IDLE;
            end
        endcase
    end

endmodule
