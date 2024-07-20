module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    // State Definitions
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;

    reg [1:0] y_counter; // Counter to monitor y input

    // State Transition (Sequential)
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic (Combinatorial)
    always @(*) begin
        // Default outputs
        f = 0;
        g = 0;
        next_state = state;

        case (state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                    f = 1; // Output f = 1 for one cycle
                end
            end
            STATE_B: begin
                if (x == 1) begin
                    next_state = STATE_C;
                end 
            end
            STATE_C: begin
                if (x == 0) begin
                    next_state = STATE_D;
                end 
            end
            STATE_D: begin
                if (x == 1) begin
                    next_state = STATE_E;
                    g = 1; // Set g to 1
                end 
            end
            STATE_E: begin
                if (y == 1) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_G;
                    y_counter = 2'b01;
                end
            end
            STATE_F: begin
                g = 1; // Maintain g = 1 permanently
            end
            STATE_G: begin
                if (y == 1) begin
                    next_state = STATE_F;
                end else if (y_counter == 2'b10) begin
                    g = 0; // Set g to 0 permanently if y not 1 within 2 clocks
                end else begin
                    y_counter = y_counter + 1;
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
