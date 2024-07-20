module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // Define states
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;

    state_t current_state, next_state;
    reg [1:0] w_count; // To count occurrences of '1' in the 'w' input

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            w_count <= 2'b00; 
            z <= 1'b0; 
        end else begin
            current_state <= next_state;
            
            if (current_state == B || current_state == C) begin
                if (current_state == B) begin
                    if (w) w_count <= w_count + 1;
                    else w_count <= w_count;
                end else if (current_state == C) begin
                    if (w) w_count <= w_count + 1;
                    if (w_count == 2'b10) z <= 1'b1; 
                    else z <= 1'b0; 
                end 
            end else begin
                w_count <= 2'b00; 
                z <= 1'b0; 
            end
        end
    end

    always_ff @(current_state or s) begin
        case (current_state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end

            B: begin
                next_state = C;
            end

            C: begin
                if (w_count == 2'b10) next_state = B;
                else next_state = C;
            end

            default: next_state = A;
        endcase
    end
endmodule
