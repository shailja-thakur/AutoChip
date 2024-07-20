module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    typedef enum reg [1:0] {
        S_A = 2'b01,
        S_B = 2'b10
    } state_t;
    
    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_A; // Reset state is A
        else
            state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            S_A: begin
                if (x) begin
                    next_state = S_B;
                    z = 1'b1;
                end else begin
                    next_state = S_A;
                    z = 1'b0;
                end
            end

            S_B: begin
                if (x) begin
                    next_state = S_B;
                    z = 1'b0;
                end else begin
                    next_state = S_B;
                    z = 1'b1;
                end
            end
            
            default: begin
                next_state = S_A;
                z = 1'b0;
            end
        endcase
    end
endmodule
