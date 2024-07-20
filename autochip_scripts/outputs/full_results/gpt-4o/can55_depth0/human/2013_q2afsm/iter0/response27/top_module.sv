module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    // State registers
    state_t current_state, next_state;

    // State table (Next state logic)
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (r[1]) 
                    next_state = STATE_B;
                else if (r[2]) 
                    next_state = STATE_C;
                else if (r[3]) 
                    next_state = STATE_D;
                else 
                    next_state = STATE_A;
            end

            STATE_B: begin
                if (r[1]) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end

            STATE_C: begin
                if (r[2]) 
                    next_state = STATE_C;
                else 
                    next_state = STATE_A;
            end

            STATE_D: begin
                next_state = STATE_A;
            end

            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                g = 3'b000;
            end

            STATE_B: begin
                g = 3'b001;
            end

            STATE_C: begin
                g = 3'b010;
            end

            STATE_D: begin
                g = 3'b100;
            end

            default: begin
                g = 3'b000;
            end
        endcase
    end
endmodule
