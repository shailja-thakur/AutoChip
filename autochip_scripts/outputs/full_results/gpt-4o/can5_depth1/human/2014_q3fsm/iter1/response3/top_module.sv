module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B0 = 3'b001,
        B1 = 3'b010,
        B2 = 3'b011,
        CHECK = 3'b100
    } state_t;

    state_t state, next_state;
    logic [1:0] w_count; // Counter for the number of w=1 in the last three clock cycles

    // State transition (sequential logic)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;

            if (state == B0 || state == B1 || state == B2) begin
                if (w) 
                    w_count <= w_count + 2'b01;
                else 
                    w_count <= w_count;
            end

            if (state == CHECK) begin
                if (w_count == 2'b10) 
                    z <= 1'b1;
                else 
                    z <= 1'b0;
                w_count <= 2'b00; // Reset the counter for the next cycle
            end
            else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B0;
                else
                    next_state = A;
            end
            B0: begin
                next_state = B1;
            end
            B1: begin
                next_state = B2;
            end
            B2: begin
                next_state = CHECK;
            end
            CHECK: begin
                next_state = B0;  // Go back to B0 to check the next three cycles
            end
            default: 
                next_state = A;
        endcase
    end

endmodule
