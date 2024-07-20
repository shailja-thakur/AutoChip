module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define states for the FSM
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    // State registers
    state_t state, next_state;
    reg [1:0] byte_count;

    // State transition and outputs
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_count <= 2'b00;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (done)
                done <= 1'b0; // Reset the done signal after one cycle
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                    byte_count = 2'b01;
                end
            end
            
            BYTE1: begin
                next_state = BYTE2;
                byte_count = 2'b10;
            end
            
            BYTE2: begin
                next_state = BYTE3;
                byte_count = 2'b11;
            end
            
            BYTE3: begin
                next_state = IDLE;
                byte_count = 2'b00;
                done = 1'b1; // Signal that three bytes have been received
            end
            
            default: begin
                next_state = IDLE;
                byte_count = 2'b00;
                done = 1'b0;
            end
        endcase
    end
endmodule
