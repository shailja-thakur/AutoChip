module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE         = 3'b000,
        S1           = 3'b001,
        S11          = 3'b010,
        S110         = 3'b011,
        LOAD         = 3'b100,
        COUNT        = 3'b101,
        NOTIFY       = 3'b110
    } state_t;
    
    state_t state, next_state;
    reg [1:0] shift_counter; // 2-bit counter to count 4 clock cycles

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 2'b00;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == LOAD) begin
                shift_counter <= shift_counter + 1'b1;
            end 
            else begin
                shift_counter <= 2'b00;
            end
        end
    end

    always_comb begin
        // Default values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = state;

        case (state)
            IDLE: begin
                if (data) next_state = S1;
            end
            
            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end
            
            S11: begin
                if (!data) next_state = S110;
                else next_state = IDLE;
            end
            
            S110: begin
                if (data) next_state = LOAD;
                else next_state = IDLE;
            end
            
            LOAD: begin
                shift_ena = 1'b0;  // Enable shifting for state transition
                if (shift_counter == 2'b11) next_state = COUNT;  // After 4 cycles go to COUNT
                else shift_ena = 1'b1;
            end
            
            COUNT: begin
                counting = 1'b1;
                if (done_counting) next_state = NOTIFY;
            end
            
            NOTIFY: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end
endmodule
