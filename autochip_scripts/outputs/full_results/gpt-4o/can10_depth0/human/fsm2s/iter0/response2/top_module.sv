module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    // State encoding
    typedef enum logic [1:0] {OFF=2'b00, ON=2'b01} state_t;
    state_t state, next_state;

    // Synchronous state and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always_comb begin
        case(state)
            OFF: begin
                out = 1'b0;
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                out = 1'b1;
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF; // Define next state in case of unexpected default
                out = 1'b0; // Safe reset state output in default case
            end
        endcase
    end
    
endmodule
