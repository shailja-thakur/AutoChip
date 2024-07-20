module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        B1 = 2'b10,
        B2 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_cnt;  // Counter to count the number of '1's in three cycles

    // Synchronous state and counter update
    always @(posedge clk) begin
        if(reset) begin
            state <= A;
            w_cnt <= 0;
        end else begin
            state <= next_state;
            if (state == B || state == B1 || state == B2)
                w_cnt <= (w_cnt + w);
            else
                w_cnt <= 0;
        end
    end

    // Next state logic
    always @* begin
        next_state = state;  // Default state
        z = 0;  // Default output
        
        case (state)
            A: begin
                if (s)
                    next_state = B;
            end
            B: begin
                next_state = B1;
            end
            B1: begin
                next_state = B2;
            end
            B2: begin
                if (w_cnt + w == 2) 
                    z = 1;
                else 
                    z = 0;
                next_state = B;
            end
        endcase
    end
endmodule
