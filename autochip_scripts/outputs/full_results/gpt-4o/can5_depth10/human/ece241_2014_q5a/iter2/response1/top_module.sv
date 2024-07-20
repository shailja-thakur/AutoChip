module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S_WAIT = 2'b00,
        S_COMP = 2'b01
    } state_t;

    reg [1:0] state, next_state;
    reg carry;  // to store carry for 2's complement

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_WAIT;
        else
            state <= next_state;
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            carry <= 1'b1;
        else if (state == S_WAIT && x) 
            carry <= 1'b0;
    end

    always @(*) begin
        next_state = state; // Default: stay in the same state
        case (state)
            S_WAIT: begin
                z = x;
                if (x == 1'b1) begin
                    next_state = S_COMP;
                    carry = 1'b0;
                end
            end
            S_COMP: begin
                z = ~x ^ carry;
                carry = carry && ~x;
            end
            default: begin
                z = x;
                next_state = S_WAIT;
            end
        endcase
    end
endmodule
