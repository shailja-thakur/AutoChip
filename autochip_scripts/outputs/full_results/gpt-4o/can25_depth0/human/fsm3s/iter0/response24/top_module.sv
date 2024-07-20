module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output and next state logic
    always @* begin
        case (state)
            A: begin
                out = 0;
                if (in) next_state = B;
                else next_state = A;
            end
            B: begin
                out = 0;
                if (in) next_state = B;
                else next_state = C;
            end
            C: begin
                out = 0;
                if (in) next_state = D;
                else next_state = A;
            end
            D: begin
                out = 1;
                if (in) next_state = B;
                else next_state = C;
            end
            default: begin
                out = 0;
                next_state = A;
            end
        endcase
    end

endmodule
