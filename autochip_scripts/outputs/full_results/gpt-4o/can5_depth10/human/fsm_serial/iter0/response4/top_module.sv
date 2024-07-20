module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [3:0] {
        IDLE = 4'd0,
        START_BIT = 4'd1,
        DATA0 = 4'd2,
        DATA1 = 4'd3,
        DATA2 = 4'd4,
        DATA3 = 4'd5,
        DATA4 = 4'd6,
        DATA5 = 4'd7,
        DATA6 = 4'd8,
        DATA7 = 4'd9,
        STOP_BIT = 4'd10,
        ERROR = 4'd11
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_counter;
    reg data_valid;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA0;
            end
            DATA0, DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7: begin
                if (bit_counter == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = current_state + 1;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit is correct
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) // Wait for stop bit
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Bit counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 3'd0;
        end else begin
            case (current_state)
                DATA0, DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7: begin
                    bit_counter <= bit_counter + 3'd1;
                end
                default: bit_counter <= 3'd0;
            endcase
        end
    end
    
endmodule
