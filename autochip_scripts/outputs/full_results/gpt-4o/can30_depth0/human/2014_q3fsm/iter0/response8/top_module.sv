module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declaration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (s) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                next_state = C;
            end
            C: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // State updating on clock
    always @(posedge clk) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Count w ones in the window
    always @(posedge clk) begin
        if (reset || state == A) 
            w_count <= 0;
        else if (state == B) 
            w_count <= (w_count + w);
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            z <= 0;
        else if (state == C) begin
            if (w_count == 2)
                z <= 1;
            else
                z <= 0;
            w_count <= 0; // Reset w_count for next window
        end
    end

endmodule
