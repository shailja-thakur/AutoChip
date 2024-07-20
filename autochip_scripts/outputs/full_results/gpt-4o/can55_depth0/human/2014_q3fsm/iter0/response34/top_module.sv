module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B1 = 3'b001,
        B2 = 3'b010,
        B3 = 3'b011,
        Z_CHECK = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [1:0] w_count;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            w_count <= 2'd0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @ (*) begin
        next_state = current_state;
        case(current_state)
            A: begin
                z = 1'b0;
                if (s)
                    next_state = B1;
            end
            B1: begin
                z = 1'b0;
                if (w)
                    w_count = w_count + 1;
                next_state = B2;
            end
            B2: begin
                z = 1'b0;
                if (w)
                    w_count = w_count + 1;
                next_state = B3;
            end
            B3: begin
                z = 1'b0;
                if (w)
                    w_count = w_count + 1;
                next_state = Z_CHECK;
            end
            Z_CHECK: begin
                if (w_count == 2'd2)
                    z = 1'b1;
                else
                    z = 1'b0;
                w_count = 2'd0;  // Reset the counter for the next cycle
                next_state = B1;  // Continue checking w in the next three cycles
            end
            default: begin
                next_state = A;
                z = 1'b0;
                w_count = 2'd0;
            end
        endcase
    end

endmodule
