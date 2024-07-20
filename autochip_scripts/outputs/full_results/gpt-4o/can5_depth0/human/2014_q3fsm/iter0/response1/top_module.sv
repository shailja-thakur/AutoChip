module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        CHECK_W_1 = 2'b10,
        CHECK_W_2 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] w_count;
    
    // State transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always_ff @(posedge clk) begin
        case (current_state)
            A: begin
                if (s)
                    next_state <= B;
                else
                    next_state <= A;
            end
            B: begin
                next_state <= CHECK_W_1;
                w_count <= 0;
            end
            CHECK_W_1: begin
                if (w) w_count <= w_count + 1;
                next_state <= CHECK_W_2;
            end
            CHECK_W_2: begin
                if (w) w_count <= w_count + 1;
                next_state <= B;
            end
            default: next_state <= A;
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk) begin
        if (current_state == CHECK_W_2 && next_state == B) begin
            if (w_count == 2'b10)
                z <= 1;
            else
                z <= 0;
        end
        else if (current_state == A)
            z <= 0;
    end
endmodule
