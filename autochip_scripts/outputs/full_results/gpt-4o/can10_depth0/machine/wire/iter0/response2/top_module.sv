module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data,   // Assuming 8-bit data output
    output reg valid
);

    // State encoding
    parameter IDLE = 2'b00,
              WAIT = 2'b01,
              PROCESS = 2'b10,
              DONE = 2'b11;

    reg [1:0] state, next_state;
    reg [7:0] counter; // Assuming 8-bit counter

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data <= 0;
            valid <= 0;
        end else begin
            state <= next_state;

            // Counter increment in WAIT state
            if (state == WAIT) begin
                counter <= counter + 1;
            end

            // Reset counter in IDLE state
            if (state == IDLE) begin
                counter <= 0;
            end
        end
    end

    // Next state logic
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
                if (counter == 8'hFF) begin  // Threshold value for transition
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

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 8'h00;
            valid <= 0;
        end else begin
            case (state)
                IDLE: begin
                    data <= 8'h00;
                    valid <= 0;
                end

                WAIT: begin
                    data <= 8'h00;
                    valid <= 0;
                end

                PROCESS: begin
                    data <= 8'hAA; // Example data to be processed
                    valid <= 0;
                end

                DONE: begin
                    valid <= 1;
                end

                default: begin
                    data <= 8'h00;
                    valid <= 0;
                end
            endcase
        end
    end

endmodule
