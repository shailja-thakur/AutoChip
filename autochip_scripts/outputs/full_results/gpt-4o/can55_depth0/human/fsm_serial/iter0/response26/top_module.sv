module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        ERROR      = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            data_reg <= 8'b00000000;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                bit_count <= bit_count + 1;
                data_reg <= {in, data_reg[7:1]}; // Shift-in incoming bits, LSB first
            end else begin
                bit_count <= 3'b000;
            end
        end
    end
    
    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 1'b0) next_state = START_BIT; // Detect start bit (0)
            end
            START_BIT: begin
                next_state = DATA_BITS; // Move to data bits state
            end
            DATA_BITS: begin
                if (bit_count == 3'd7) next_state = STOP_BIT; // All 8 data bits received
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1; // Correct stop bit received
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Error if stop bit is not 1
                end
            end
            ERROR: begin
                if (in == 1'b1) next_state = IDLE; // Wait for line to go idle
            end
        endcase
    end
endmodule
