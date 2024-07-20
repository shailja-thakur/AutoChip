module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Declare state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    reg [1:0] current_state, next_state;
    
    // State transition on clock edge
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end
            default: next_state = STATE_B;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule
