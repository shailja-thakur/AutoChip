module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Internal state definitions
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [7:0] counter;

    // Next state logic
    always @(*) begin
        next_state = state;
        case(state)
            IDLE: begin
                if (reset)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end

            WAIT: begin
                if (counter == 8'd255)
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

    // State and counter update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else begin
                counter <= 8'd0;
            end
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case(state)
                IDLE: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end

                WAIT: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end

                PROCESS: begin
                    data_out <= counter; // Example processing: output the counter value
                    valid_out <= 1'b0;
                end

                DONE: begin
                    valid_out <= 1'b1;
                end

                default: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
            endcase
        end
    end

endmodule
