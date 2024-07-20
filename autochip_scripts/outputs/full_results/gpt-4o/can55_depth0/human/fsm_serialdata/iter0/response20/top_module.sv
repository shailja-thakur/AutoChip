module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        START    = 3'b001,
        DATA     = 3'b010,
        STOP     = 3'b011,
        VALID    = 3'b100
    } state_t;
    
    // State variables
    state_t state, next_state;
    
    // Data byte and bit count
    reg [7:0] byte_data;
    reg [2:0] bit_count;
    
    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and data capturing
    always_ff @(posedge clk) begin
        if (reset) begin
            byte_data <= 8'b0;
            bit_count <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            done <= 1'b0; // Default value
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin // Start bit detected
                        next_state <= START;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                START: begin
                    next_state <= DATA;
                    bit_count <= 3'b0;
                end
                DATA: begin
                    byte_data[bit_count] <= in; // Capture data bit
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'b111) begin
                        next_state <= STOP;
                    end else begin
                        next_state <= DATA;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin // Stop bit detected
                        out_byte <= byte_data;
                        done <= 1'b1;
                        next_state <= VALID;
                    end else begin
                        next_state <= IDLE; // Wait for a new start bit
                    end
                end
                VALID: begin
                    next_state <= IDLE; // Return to IDLE after valid byte capture
                end
                default: next_state <= IDLE;
            endcase
        end
    end
endmodule
