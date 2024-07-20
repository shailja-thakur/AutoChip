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
        C1 = 2'b10,
        C2 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
            
            if (state == B) begin
                cycle_count <= cycle_count + 1;

                if (w) 
                    w_count <= w_count + 1;

                if (cycle_count == 2'b11) begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                    w_count <= 2'b00;
                    cycle_count <= 2'b00;
                end
            end else begin
                cycle_count <= 2'b00;
                w_count <= 2'b00;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            
            B: begin
                if (cycle_count == 2'b11)
                    next_state = B;
                else
                    next_state = B;
            end
            
            default: next_state = A;
        endcase
    end

endmodule
