module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S0 = 3'b001,  // 0
        S1 = 3'b010,  // 01
        S2 = 3'b011,  // 011
        S3 = 3'b100,  // 0111
        S4 = 3'b101,  // 01111
        S5 = 3'b110,  // 011111
        S6 = 3'b111   // 0111111 or error
    } state_t;

    reg [2:0] current_state, next_state;
    reg in_d;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            in_d <= 1'b0;
        end else begin
            current_state <= next_state;
            in_d <= in;
        end
    end

    // Next state logic
    always @(*) begin
        // Default outputs
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = S0;
                end else begin
                    next_state = S1;
                end
            end
            S0: begin
                if (in == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (in == 1'b1) begin
                    next_state = S2;
                end else begin
                    next_state = IDLE;
                end
            end
            S2: begin
                if (in == 1'b1) begin
                    next_state = S3;
                end else begin
                    next_state = IDLE;
                end
            end
            S3: begin
                if (in == 1'b1) begin
                    next_state = S4;
                end else begin
                    next_state = IDLE;
                end
            end
            S4: begin
                if (in == 1'b1) begin
                    next_state = S5;
                end else begin
                    next_state = IDLE;
                end
            end
            S5: begin
                if (in == 1'b1) begin
                    next_state = S6;
                end else begin
                    next_state = S0; // 0111110 detected, require to discard bit
                end
            end
            S6: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // 01111110 detected, flag
                end else begin
                    next_state = IDLE;
                end
                // Output assignments for "011111" in the state machine
                case({in, in_d})
                    2'b10: flag = 1'b1; // 01111110 detected
                    2'b00: disc = 1'b1; // 0111110 detected
                    2'b11: err = 1'b1; // 01111111... detected
                    default: ;
                endcase
            end
        endcase
    end

endmodule
