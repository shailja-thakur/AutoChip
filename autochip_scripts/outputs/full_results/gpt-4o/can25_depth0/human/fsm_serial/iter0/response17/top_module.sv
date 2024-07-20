module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    reg [3:0] state, next_state;
    reg [2:0] bit_counter;

    // Define states
    localparam IDLE      = 4'd0,
               START_BIT = 4'd1,
               DATA_BITS = 4'd2,
               STOP_BIT  = 4'd3,
               DONE      = 4'd4,
               ERROR     = 4'd5;

    // State Transition Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_counter == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = DONE;
                else
                    next_state = ERROR;
            end
            DONE: begin
                next_state = IDLE;
            end
            ERROR: begin
                if (in == 1'b1) // Find the stop bit before returning to IDLE
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // State and Counter Update Logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;

            case (state)
                DATA_BITS: begin
                    bit_counter <= bit_counter + 3'd1;
                end
                default: begin
                    bit_counter <= 3'd0;
                end
            endcase
            
            if (state == DONE) begin
                done <= 1'b1;
            end
            else begin
                done <= 1'b0;
            end
        end
    end

endmodule
