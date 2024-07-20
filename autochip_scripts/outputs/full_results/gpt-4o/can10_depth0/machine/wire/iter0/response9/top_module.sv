module top_module(
    input wire clk,          // Clock input
    input wire reset,        // Reset input
    output reg [7:0] data,   // Data output
    output reg valid         // Valid output
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;  // Current and next state
    reg [7:0] counter;          // Counter to keep track of clock cycles

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data <= 8'b0;
            valid <= 1'b0;
        end else begin
            state <= next_state;
            if (state == WAIT) counter <= counter + 1;
            else counter <= 8'b0;
        end
    end

    // State transition and output logic (combinational)
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (reset) next_state = IDLE;
                else next_state = WAIT;
                data = 8'b0;
                valid = 1'b0;
            end
            WAIT: begin
                if (counter < 8'd255) next_state = WAIT;
                else next_state = PROCESS;
                data = 8'b0;
                valid = 1'b0;
            end
            PROCESS: begin
                next_state = DONE;
                data = 8'hAA;  // Example data processing
                valid = 1'b0;
            end
            DONE: begin
                next_state = IDLE;
                valid = 1'b1;
            end
        endcase
    end
endmodule
