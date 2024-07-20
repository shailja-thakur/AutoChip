module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State declaration
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State flip-flops (sequential logic)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A; // synchronous reset
        else
            state <= next_state;
    end

    // State table (combinational logic)
    always @(*) begin
        case (state)
            STATE_A: begin
                if (r[1] == 1)
                    next_state = STATE_B;
                else if (r[2] == 1)
                    next_state = STATE_C;
                else if (r[3] == 1)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (r[1] == 1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[2] == 1)
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                next_state = STATE_A;
            end
            default: next_state = STATE_A; // Default state to handle async condition
        endcase
    end

    // Output logic based on state
    always @(*) begin
        case (state)
            STATE_A: g = 3'b000; // No grants
            STATE_B: g = 3'b001; // Device 1 grant
            STATE_C: g = 3'b010; // Device 2 grant
            STATE_D: g = 3'b100; // Device 3 grant
            default: g = 3'b000; // Default, no grants
        endcase
    end

endmodule
