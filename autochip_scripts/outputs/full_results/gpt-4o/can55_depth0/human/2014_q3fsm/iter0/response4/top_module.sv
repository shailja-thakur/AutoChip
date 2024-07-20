module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] count; // Counter to track number of times w=1 in three cycles
    
    // State transition logic (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == B || state == C || state == D) begin
                if (count == 2'd2) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end
            end
            if (state == A) begin
                z <= 0;
            end
        end
    end

    // Combinational logic for state transitions and count updates
    always @(*) begin
        next_state = state;
        
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = C;
            end
            C: begin
                next_state = D;
            end
            D: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end
    
    // Counter logic to count the number of 1s in 'w'
    always @(posedge clk) begin
        if (reset || state == A) begin
            count <= 0;
        end else if (state == B || state == C || state == D) begin
            if (w) begin
                count <= count + 1;
            end
            // On entering state D, do not count the current value of w again
            if (state == D) begin
                count <= 0; // reset count for the next 3 cycles consideration.
            end
        end
    end

endmodule
