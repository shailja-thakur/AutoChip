module top_module (
    input clk,
    input in,
    input reset,
    output done
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
    logic [2:0] bit_counter;
    logic done_reg;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            done_reg <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 3'b000;
            end
            
            if (current_state == STOP && in == 1'b1) begin
                done_reg <= 1'b1;
            end else if (current_state == STOP) begin
                done_reg <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            
            START: begin
                next_state = DATA;
            end
            
            DATA: begin
                if (bit_counter == 3'd7) begin
                    next_state = STOP;
                end
            end
            
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Output assignment
    assign done = done_reg;

endmodule
