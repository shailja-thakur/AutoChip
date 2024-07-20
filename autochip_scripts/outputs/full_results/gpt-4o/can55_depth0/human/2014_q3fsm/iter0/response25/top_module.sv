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

    // Next state logic
    always @(*) begin
        next_state = state;
        z = 0; // default output
        case(state)
            A: begin
                if (s)
                    next_state = B;
            end
            B: begin
                if (w_count == 2)
                    z = 1;
                if (w_count == 3)
                    next_state = A;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // State transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
        end else begin
            if (state == B) begin
                if (w)
                    w_count <= w_count + 1;
                else
                    w_count <= w_count;
                
                if (w_count == 3)
                    w_count <= 0;
            end else begin
                w_count <= 0;
            end
            
            state <= next_state;
        end
    end
endmodule
