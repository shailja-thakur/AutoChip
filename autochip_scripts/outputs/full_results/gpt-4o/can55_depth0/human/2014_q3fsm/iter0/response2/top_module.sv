module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define states
    typedef enum reg [1:0] {
        A,  // Initial/reset state
        B,  // Counting w values
        C,  // Hold state to wait for z to be evaluated
        D   // Unused state
    } state_t;
    
    reg [1:0] current_state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;

            if (current_state == B) begin
                cycle_count <= cycle_count + 1;
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (cycle_count == 2'b10) begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                end
            end
            else if (current_state == C) begin
                if (cycle_count == 2'b10) begin
                    w_count <= 2'b00;
                    cycle_count <= 2'b00;
                    z <= 1'b0;
                end
            end
            else begin
                z <= 1'b0;
                w_count <= 2'b00;
                cycle_count <= 2'b00; 
            end
        end
    end

    always @(*) begin
        case (current_state)
            A: begin
                if (s) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (cycle_count == 2'b10) 
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
