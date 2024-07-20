module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        START = 2'b01,
        RECEIVING = 2'b10,
        STOP = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            shift_reg <= 8'b0;
            out_byte <= 8'b0;
            done <= 0;
        end else begin
            state <= next_state;
            
            if (state == START) begin
                bit_count <= 3'b000;
                shift_reg <= 8'b0;
            end else if (state == RECEIVING) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end else if (state == STOP) begin
                out_byte <= shift_reg;
            end
            
            if (state == STOP && in == 1) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end
    
    always @* begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 0) // detect start bit
                    next_state = START;
            end
            START: begin
                next_state = RECEIVING;
            end
            RECEIVING: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1) // check for stop bit
                    next_state = IDLE;
                else
                    next_state = IDLE; // if not correct, go back to idle
            end
        endcase
    end
    
endmodule
