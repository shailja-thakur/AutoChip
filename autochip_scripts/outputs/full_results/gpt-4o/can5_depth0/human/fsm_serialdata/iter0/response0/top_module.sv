module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_shift_reg;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            out_byte <= 8'd0;
            data_shift_reg <= 8'd0;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
            
            // State machine actions
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                end
                START: begin
                    // Start bit detected
                end
                DATA: begin
                    data_shift_reg <= {in, data_shift_reg[7:1]}; // Shift in new bit
                    bit_count <= bit_count + 1'd1;
                end
                STOP: begin
                    out_byte <= data_shift_reg;
                    done <= 1'b1;
                end
                ERROR: begin
                    done <= 1'b0;
                end
            endcase
        end
    end
    
    always_comb begin
        // Default next state
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA; // Move to data state
                bit_count = 0;
            end
            DATA: begin
                if (bit_count == 3'd7) // Check if all 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = IDLE;
                else
                    next_state = ERROR; // Error if stop bit not detected
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE; // Wait for idle state to resume
            end
        endcase
    end
endmodule
