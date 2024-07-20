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
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        z = 0;
        
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                next_state = C;
                w_count = 0;
                cycle_count = 0;
            end

            C: begin
                if (cycle_count < 3) begin
                    next_state = C;
                end else begin
                    if (w_count == 2)
                        z = 1;
                    else
                        z = 0;
                    next_state = B;
                end
            end
            
            D: begin
                // This state is not actually required in this implementation
                next_state = B;
            end
        endcase
    end

    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_count <= 0;
            cycle_count <= 0;
        end else if (cycle_count < 3 && state == C) begin
            cycle_count <= cycle_count + 1;
            if (w) 
                w_count <= w_count + 1;
        end else if (state == B) begin
            w_count <= 0;
            cycle_count <= 0;
            z <= 0;
        end else begin
            z <= 0;
        end
    end
    
endmodule
