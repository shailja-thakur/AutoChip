module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    typedef enum logic [1:0] {
        A = 2'b00, // Reset state
        B = 2'b01, // Check w for the next three clock cycles
        C = 2'b10  // Ignore s and continue checking w
    } state_t;
    
    state_t state, next_state;
    reg [1:0] count; // Counter for w=1 instances in three cycles
    reg [1:0] cycle; // Counter for three clock cycles
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            count <= 0;
            cycle <= 0;
            z <= 0;
        end
        else begin
            state <= next_state;
            if (state == B) begin
                if (w)
                    count <= count + 1;
                cycle <= cycle + 1;
                // After three cycles check count
                if (cycle == 2) begin
                    z <= (count == 2) ? 1 : 0;
                    cycle <= 0;
                    count <= 0;
                end
                else
                    z <= 0;
            end else begin
                z <= 0;
            end
        end
    end

    always_comb begin
        case (state)
            A: begin
                if (s) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (cycle == 2)
                    next_state = C;
                else
                    next_state = B;
            end
            C: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

endmodule
