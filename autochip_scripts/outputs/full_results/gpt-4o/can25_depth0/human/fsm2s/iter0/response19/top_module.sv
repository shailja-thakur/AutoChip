module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k == 1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF; // Default state
        endcase
    end

    // State register and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
            out <= 0;
        end else begin
            state <= next_state;
            out <= (state == ON) ? 1 : 0;
        end
    end
    
endmodule
