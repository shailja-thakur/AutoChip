module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;

    reg [3:0] counter;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'd0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else begin
                counter <= 4'd0;
            end
        end
    end

    // Combinational logic for next state logic and outputs
    always @* begin
        // Default values
        next_state = state;
        data_out = 8'd0;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (counter < 4'd10) begin
                    next_state = WAIT;
                end else begin
                    next_state = PROCESS;
                end
            end
            PROCESS: begin
                data_out = 8'hFF;  // Example data being processed
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule
