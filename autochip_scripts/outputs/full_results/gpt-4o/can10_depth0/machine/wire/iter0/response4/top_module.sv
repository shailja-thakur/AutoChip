module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State Declaration
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // Signal Declaration
    state_t state, next_state;
    reg [7:0] counter;

    // State Transition Logic (Sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;

            // Counter and Data Output Logic
            if (state == WAIT) begin
                counter <= counter + 1;
                data_out <= 8'd0;
            end else if (state == PROCESS) begin
                data_out <= 8'hFF;  // Example data; replace with actual data processing logic
            end
            
            // Valid Output Logic
            if (state == DONE) begin
                valid_out <= 1'b1;
            end else begin
                valid_out <= 1'b0;
            end
        end
    end

    // Next State Logic (Combinational)
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (counter >= 8'd255) begin // Example threshold; replace with actual value
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
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
