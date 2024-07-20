module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // FSM States
    typedef enum logic [3:0] {
        IDLE          = 4'd0,
        START_BIT     = 4'd1,
        RECEIVE_BIT_0 = 4'd2,
        RECEIVE_BIT_1 = 4'd3,
        RECEIVE_BIT_2 = 4'd4,
        RECEIVE_BIT_3 = 4'd5,
        RECEIVE_BIT_4 = 4'd6,
        RECEIVE_BIT_5 = 4'd7,
        RECEIVE_BIT_6 = 4'd8,
        RECEIVE_BIT_7 = 4'd9,
        STOP_BIT      = 4'd10
    } state_t;

    // State and next state variables
    state_t state, next_state;
    reg [7:0] shift_reg; // Shift register to store data bits
    integer bit_count;   // Counter for data bits

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @* begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit (0)
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = RECEIVE_BIT_0;
            end
            RECEIVE_BIT_0: begin
                next_state = RECEIVE_BIT_1;
            end
            RECEIVE_BIT_1: begin
                next_state = RECEIVE_BIT_2;
            end
            RECEIVE_BIT_2: begin
                next_state = RECEIVE_BIT_3;
            end
            RECEIVE_BIT_3: begin
                next_state = RECEIVE_BIT_4;
            end
            RECEIVE_BIT_4: begin
                next_state = RECEIVE_BIT_5;
            end
            RECEIVE_BIT_5: begin
                next_state = RECEIVE_BIT_6;
            end
            RECEIVE_BIT_6: begin
                next_state = RECEIVE_BIT_7;
            end
            RECEIVE_BIT_7: begin
                next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Detect stop bit (1)
                    done = 1'b1;
                    next_state = IDLE;
                end
                else
                    next_state = IDLE; // Wait for correct stop bit before new start
            end
            default: next_state = IDLE;
        endcase
    end

    // Shift register and bit counting logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'b0;
            out_byte <= 8'b0;
            bit_count <= 0;
        end
        else begin
            if (state == IDLE || state == STOP_BIT)
                bit_count <= 0;
            else if (state >= RECEIVE_BIT_0 && state <= RECEIVE_BIT_7) begin
                shift_reg <= {in, shift_reg[7:1]}; // Shift in the data bit
                bit_count <= bit_count + 1;
            end

            if (state == STOP_BIT && in == 1'b1) begin
                out_byte <= shift_reg; // Assign the received data byte to output
            end
        end
    end
endmodule
