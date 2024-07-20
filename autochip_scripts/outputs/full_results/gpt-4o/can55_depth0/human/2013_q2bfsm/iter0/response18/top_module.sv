module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    // Current state and next state
    state_t current_state, next_state;

    // Counters
    reg [1:0] y_counter;

    // Sequential logic for state transitions
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs and signals
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;
        
        case (current_state)
            STATE_A: begin
                if (~resetn) begin
                    next_state = STATE_B;
                end
            end
            
            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end
            
            STATE_C: begin
                if (x) begin
                    next_state = STATE_D;
                end else if (resetn) begin
                    next_state = STATE_A;
                end
            end
            
            STATE_D: begin
                if (~x) begin
                    next_state = STATE_E;
                end else if (resetn) begin
                    next_state = STATE_A;
                end
            end
            
            STATE_E: begin
                if (x) begin
                    g = 1'b1;
                    next_state = STATE_F;
                end else if (resetn) begin
                    next_state = STATE_A;
                end
            end
            
            STATE_F: begin
                g = 1'b1;
                if (y) begin
                    // Maintain g = 1 permanently
                end else if (y_counter < 2) begin
                    y_counter = y_counter + 1;
                end else begin
                    g = 1'b0;
                end
                if (resetn) begin
                    next_state = STATE_A;
                    y_counter = 0;
                end
            end
            
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
